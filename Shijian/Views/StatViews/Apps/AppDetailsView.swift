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
                .padding()
                .frame(height: 200)
            
            
            Spacer()
        }
    }
}

#Preview {
    @State var shouldOpenSheet: Bool = false
    
    return AppDetailsView(
        app: AppInfo.testData.first!,
        times: AppInfo.testData.first!.times,
        period: .last7Days,
        shouldOpenSheet: $shouldOpenSheet
    )
}
