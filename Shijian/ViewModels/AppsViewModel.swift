import Foundation

class AppsViewModel: ObservableObject {
    @Published var apps: [AppInfo] = []
    @Published var categoryLimits: [AppCategory: Date] = [:] // temps en secondes
    @Published var globalTimer: Date? = nil
    
    init() {
        getApps()
    }
    
    func getApps(){
        self.apps.append(contentsOf: AppInfo.testData)
        self.categoryLimits = AppCategory.testData
        self.globalTimer = Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!
    }
    
    func getAppByName(name: String) -> AppInfo? {
        self.apps.first(where: { a in
            a.name == name
        })
    }
    
    func changeAppLimit(app_name: String, newTimeLimitation: Date?) {
        var app = getAppByName(name: app_name)
        if app == nil { return }
        
        app?.limiterTime = newTimeLimitation;
    }
    
    func changeCategoryLimit(category: AppCategory, newLimit: Date) {
        categoryLimits[category] = newLimit
    }

    func getCategoryLimit(category: AppCategory) -> Date? {
        return categoryLimits[category]
    }
    
    func setGlobalTimer(timer: Date?) {
        globalTimer = timer;
    }
}
