//
//  AppsViewModel.swift
//  Shijian
//
//  Created by colin cedric on 11/03/2025.
//

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
}
