import Foundation
import Charts

enum AppCategory: String, CaseIterable, Identifiable {
    case social = "Réseaux sociaux"
    case games = "Jeux"
    case util = "Outil"
    case unknown = "Inconnu"
    
    var id: Self { self }
}

struct AppInfo: Identifiable {
    var id = UUID()
    var name: String
    var category: AppCategory = .unknown
    var times: [AppTime]
    
    static let dateFormatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "DD-MM-YYYY"
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
        ),
        AppInfo(
            name: "Discord",
            category: .social,
            times: []
        )
    ]
}

enum TimePeriod: String, CaseIterable, Identifiable {
    case today = "Aujourd'hui"
    case last7Days = "7 jours"
    case lastMonth = "1 mois"
    case last12Months = "12 mois"

    var id: Self { self }
}
