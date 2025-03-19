import Foundation

struct AppStatData: Identifiable {
    let id = UUID()
    let appName: String
    let time: TimeInterval
    let progressPercentage: Double
    let app: AppInfo
}
