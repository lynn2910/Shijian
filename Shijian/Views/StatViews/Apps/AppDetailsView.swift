import SwiftUI
import Charts

struct AppDetailsView: View {
    var app: AppInfo
    var times: [AppTime]
    var period: TimePeriod
    
    @Binding var shouldOpenSheet: Bool
    @State private var isTimeSelectionVisible = false
    
    @EnvironmentObject var appsVM: AppsViewModel
    
    var formattedSelectedTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated

        guard let limiterTime = app.limiterTime else {
            return ""
        }

        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: limiterTime)

        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)

        if let dateWithTime = calendar.date(byAdding: components, to: startOfDay) {
            let interval = dateWithTime.timeIntervalSince(startOfDay)
            if interval <= 3600 { return "0h" }
            return formatter.string(from: interval) ?? ""
        } else {
            return ""
        }
    }
    
    var body: some View {
        @State var selectedTime = app.limiterTime ?? Date.init(timeIntervalSince1970: 0);
        
        VStack(alignment: .center) {
            // header
            HStack {
                Spacer()
                
                Text("\(app.name)")
                    .font(.title2)
                    .bold()
                    .padding(.leading, 60)
                
                Spacer()
                
                Button {
                    shouldOpenSheet.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.all, 20)
                        .foregroundColor(.black)
                }
            }
            
            Text("Période affichée: \(period.rawValue)")
            
            // Graphique d'utilisation
            Chart(times) { time in
                switch (period) {
                    case .today:
                        BarMark(
                            x: .value("Heure", time.date),
                            y: .value("Temps", time.time / 60 / 24)
                        )
                    case .last7Days:
                        BarMark(
                            x: .value("Jour", time.date),
                            y: .value("Temps", time.time / 60 / 24 / 7)
                        )
                    default:
                        BarMark(
                            x: .value("Mois", time.date),
                            y: .value("Temps", time.time / 60 / 24)
                        )
                }
            }
            .chartXAxis {
                switch(period) {
                    case .today:
                        AxisMarks(values: .stride(by: .hour)) { value in
                            AxisValueLabel(format: .dateTime.hour())
                        }
                    case .last7Days:
                        AxisMarks(values: .stride(by: .day, count: 7)) { value in
                            AxisValueLabel(format: .dateTime.day())
                        }
                    case .lastMonth:
                        AxisMarks(values: .stride(by: .day, count: 30)) { value in
                            AxisValueLabel(format: .dateTime.day())
                        }
                    case .last12Months:
                        AxisMarks(values: .stride(by: .month, count: 12)) { value in
                            AxisValueLabel(format: .dateTime.month())
                        }
                }
            }
            .chartYAxis {
                AxisMarks(values: .automatic) { value in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel {
                        if let value = value.as(Int.self) {
                            Text("\(value) h")
                        }
                        else if let value = value.as(Double.self) {
                            Text("\(String(format: "%.1f", value)) h")
                        }
                    }
                }
            }
                .padding()
                .frame(height: 200)
            
            
            Spacer(minLength: 10)
            
            // Settings
            
            Text("Paramètres")
                .font(.title2)
                .bold()
                .multilineTextAlignment(.leading)
            
            HStack {
                Button {
                    isTimeSelectionVisible.toggle()
                } label: {
                    HStack {
                        Image(systemName: "hourglass")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 25, height: 25)

                        VStack(alignment: .leading) {
                            Text("Minuteur d'application")
                            HStack(alignment: .firstTextBaseline) {
                                Text(formattedSelectedTime)
                            }
                        }
                    }.padding(.horizontal)
                }.buttonStyle(PlainButtonStyle())
                
                
                Rectangle()
                    .frame(width: 2, height: 30)
                    .padding(.horizontal)
                
                
                Button {
                    appsVM.changeAppLimit(app_name: app.name, newTimeLimitation: Date.init(timeIntervalSince1970: 0))
                    selectedTime = Date.init(timeIntervalSince1970: 0)
                } label: {
                    Image(systemName: "trash.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            Spacer()
        }
        .sheet(isPresented: $isTimeSelectionVisible) {
            NavigationView {
                VStack {
                    DatePicker("Please enter a time", selection: $selectedTime, displayedComponents: .hourAndMinute).padding()
                    
                    Spacer(minLength: 10)
                    Button {
                        appsVM.changeAppLimit(app_name: app.name, newTimeLimitation: selectedTime)
                        isTimeSelectionVisible.toggle()
                    } label: {
                        Text("Définir le nouveau temps")
                    }
                    
                    Spacer()
                }
                .navigationTitle("Sélectionner le temps")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Annuler") {
                            isTimeSelectionVisible.toggle()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    @State var shouldOpenSheet: Bool = false
    
    return AppDetailsView(
        app: AppInfo.testData.first!,
        times: AppInfo.testData.first!.times,
        period: .last12Months,
        shouldOpenSheet: $shouldOpenSheet
    ).environmentObject(AppsViewModel())
}
