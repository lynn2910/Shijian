import Foundation

class AppsViewModel: ObservableObject {
    @Published var apps: [AppInfo] = []
    
    init() {
        getApps()
    }
    
    func getApps(){
        self.apps.append(contentsOf: AppInfo.testData)
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
}
