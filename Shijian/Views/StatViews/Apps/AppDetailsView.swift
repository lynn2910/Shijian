import SwiftUI
import Charts

struct AppDetailsView: View {
    var app: AppInfo
    var times: [AppTime]
    var period: TimePeriod
    
    @Binding var shouldOpenSheet: Bool
    
    var body: some View {
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
                Image(systemName: "hourglass")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                
                VStack(alignment: .leading) {
                    Text("Minuteur d'application")
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text("1 h et 30 min")
                    }
                }.padding(.horizontal)
                
                
                Rectangle()
                    .frame(width: 2, height: 30)
                    .padding(.horizontal)
                
                Image(systemName: "trash.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
            }
            
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    @State var shouldOpenSheet: Bool = false
    
    return AppDetailsView(
        app: AppInfo.testData.first!,
        times: AppInfo.testData.first!.times,
        period: .lastMonth,
        shouldOpenSheet: $shouldOpenSheet
    )
}
