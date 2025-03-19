import Foundation
import Charts

enum AppCategory: String, CaseIterable {
    case social = "Réseaux sociaux"
    case games = "Jeux"
    case util = "Outil"
    case unknown = "Inconnu"
}

struct AppInfo: Identifiable {
    var id = UUID()
    var name: String
    var category: AppCategory = .unknown
    var times: [AppTime]
    
    static let dateFormatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "dd-MM-YYYY"
        return fmt
    }()
    
    static var testData = [
        AppInfo(
            name: "Instagram",
            category: .social,
            times: [
                AppTime(date: dateFormatter.date(from: "01-01-2025").unsafelyUnwrapped, time: 7560),
                AppTime(date: dateFormatter.date(from: "02-01-2025").unsafelyUnwrapped, time: 7560),
                AppTime(date: dateFormatter.date(from: "03-01-2025").unsafelyUnwrapped, time: 27900),
                AppTime(date: dateFormatter.date(from: "18-03-2025").unsafelyUnwrapped, time: 3000),
                AppTime(date: Date(), time: 2880)
            ]
        ),
        AppInfo(
            name: "Crumble",
            category: .util,
            times: [
                AppTime(date: dateFormatter.date(from: "07-01-2025").unsafelyUnwrapped, time: 1860),
                AppTime(date: dateFormatter.date(from: "09-01-2025").unsafelyUnwrapped, time: 4560),
                AppTime(date: Date(), time: 3540),
            ]
        )
    ]
}

struct AppUsageData: Identifiable {
    let id = UUID()
    let app: AppInfo
    let time: TimeInterval
}

extension AppInfo {
    func usageData() -> [AppUsageData] {
        return times.map { time in
            AppUsageData(app: self, time: TimeInterval(time.time))
        }
    }
}

extension Array where Element == AppInfo {
    func allUsageData() -> [AppUsageData] {
        return flatMap { $0.usageData() }
    }
}

enum TimePeriod: String, CaseIterable, Identifiable {
    case today = "Aujourd'hui"
    case last7Days = "7 jours"
    case lastMonth = "1 mois"
    case last12Months = "12 mois"

    var id: Self { self }
}

func filterUsageData(data: [AppUsageData], period: TimePeriod) -> [AppUsageData] {
    let now = Date()
    let calendar = Calendar.current

    switch period {
    case .today:
        return data.filter { usage in
            usage.app.times.contains { time in
                calendar.isDateInToday(time.date)
            }
        }.flatMap { usage in
            usage.app.times.filter { time in
                calendar.isDateInToday(time.date)
            }.map { time in
                AppUsageData(app: usage.app, time: TimeInterval(time.time))
            }
        }
    case .last7Days:
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: now)!
        return data.filter { usage in
            usage.app.times.contains { time in
                time.date >= sevenDaysAgo && time.date <= now
            }
        }.flatMap { usage in
            usage.app.times.filter { time in
                time.date >= sevenDaysAgo && time.date <= now
            }.map { time in
                AppUsageData(app: usage.app, time: TimeInterval(time.time))
            }
        }
    case .lastMonth:
        let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: now)!
        return data.filter { usage in
            usage.app.times.contains { time in
                time.date >= oneMonthAgo && time.date <= now
            }
        }.flatMap { usage in
            usage.app.times.filter { time in
                time.date >= oneMonthAgo && time.date <= now
            }.map { time in
                AppUsageData(app: usage.app, time: TimeInterval(time.time))
            }
        }
    case .last12Months:
        let twelveMonthsAgo = calendar.date(byAdding: .year, value: -1, to: now)!
        return data.filter { usage in
            usage.app.times.contains { time in
                time.date >= twelveMonthsAgo && time.date <= now
            }
        }.flatMap { usage in
            usage.app.times.filter { time in
                time.date >= twelveMonthsAgo && time.date <= now
            }.map { time in
                AppUsageData(app: usage.app, time: TimeInterval(time.time))
            }
        }
    }
}

func aggregateUsageData(data: [AppUsageData]) -> [String: TimeInterval] {
    var aggregatedData: [String: TimeInterval] = [:]
    for usage in data {
        aggregatedData[usage.app.name, default: 0] += usage.time
    }
    return aggregatedData
}


struct AppUsageBarData: Identifiable {
    let id = UUID()
    let appName: String
    let time: TimeInterval
    let date: Date
    let appInfo: AppInfo
}

func prepareBarChartData(data: [AppUsageData], period: TimePeriod) -> [AppUsageBarData] {
    let filteredData = filterUsageData(data: data, period: period)
    var dailyUsage: [Date: [String: TimeInterval]] = [:]

    for usage in filteredData {
        let calendar = Calendar.current
        let date = calendar.startOfDay(for: usage.app.times.last?.date ?? Date())

        if dailyUsage[date] == nil {
            dailyUsage[date] = [:]
        }
        dailyUsage[date]![usage.app.name, default: 0] += usage.time
    }

    var barData: [AppUsageBarData] = []
    for (date, appUsages) in dailyUsage {
        for (appName, time) in appUsages {
            barData.append(AppUsageBarData(
                    appName: appName,
                    time: time,
                    date: date,
                    appInfo: AppInfo.testData.first(where: { app in
                        app.name == appName
                    }) ?? AppInfo(name: appName, category: .unknown, times: [])
                )
            )
        }
    }

    return barData
}
