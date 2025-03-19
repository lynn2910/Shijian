
import SwiftUI
import Charts

struct AppStats: View {
    
    @State private var selectedPeriod: TimePeriod = .today
    
    @EnvironmentObject var appsVM: AppsViewModel
    
    func calculateAppStats(data: [AppUsageData], period: TimePeriod) -> [AppStatData] {
        let filteredData = filterUsageData(data: data, period: period)
        let aggregatedData = aggregateUsageData(data: filteredData)
        let totalTime = aggregatedData.values.reduce(0, +)

        return aggregatedData.map { (appName, time) in
            let progressPercentage = totalTime > 0 ? Double(time) / Double(totalTime) : 0
            
            return AppStatData(
                appName: appName,
                time: time,
                progressPercentage: progressPercentage,
                app: appsVM.getAppByName(name: appName) ?? AppInfo(name: appName, times: [])
            )
        }
    }

    func formatTime(_ timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval / 3600)
        let minutes = Int((timeInterval.truncatingRemainder(dividingBy: 3600)) / 60)
        return String(format: "%dh %02dm", hours, minutes)
    }
    
    var body: some View {
        VStack {
            // Picker
            Picker("Période", selection: $selectedPeriod) {
                ForEach(TimePeriod.allCases) { period in
                    Text(period.rawValue).tag(period)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Chart
            Chart(prepareBarChartData(data: AppInfo.testData.allUsageData(), period: selectedPeriod)) { dataPoint in
                            BarMark(
                                x: .value("Date", dataPoint.date, unit: .day),
                                y: .value("Temps", dataPoint.time)
                            )
                            .foregroundStyle(by: .value("Application", dataPoint.appName))
                        }
                        .chartXAxis {
                            AxisMarks(values: .stride(by: .day)) { value in
                                AxisValueLabel(format: .dateTime.hour())
                            }
                        }
                        .chartYAxis {
                            AxisMarks { value in
                                if let timeInterval = value.as(TimeInterval.self) {
                                    AxisValueLabel {
                                        Text(formatTime(timeInterval))
                                    }
                                }
                            }
                        }
                        .padding()
            
            // Apps list
            ScrollView {
                VStack {
                    ForEach(calculateAppStats(data: AppInfo.testData.allUsageData(), period: selectedPeriod)) { appStat in
                        AppStatsCard(
                            progressPercentage: appStat.progressPercentage,
                            time: formatTime(appStat.time),
                            name: appStat.appName,
                            appInfo: appStat.app
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    AppStats()
        .environmentObject(AppsViewModel())
}
