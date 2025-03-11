//
//  App.swift
//  Shijian
//
//  Created by colin cedric on 11/03/2025.
//

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
                AppTime(date: dateFormatter.date(from: "25-01-2025").unsafelyUnwrapped, time: 3000),
                AppTime(date: dateFormatter.date(from: "26-01-2025").unsafelyUnwrapped, time: 2880)
            ]
        ),
        AppInfo(
            name: "Crumble",
            category: .util,
            times: [
                AppTime(date: dateFormatter.date(from: "07-01-2025").unsafelyUnwrapped, time: 1860),
                AppTime(date: dateFormatter.date(from: "09-01-2025").unsafelyUnwrapped, time: 4560),
                AppTime(date: dateFormatter.date(from: "11-01-2025").unsafelyUnwrapped, time: 3540),
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
