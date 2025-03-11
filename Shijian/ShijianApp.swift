//
//  ShijianApp.swift
//  Shijian
//
//  Created by colin cedric on 18/02/2025.
//

import SwiftUI

@main
struct ShijianApp: App {
    init() {
        UITabBar.appearance().isTranslucent = false;
        UITabBar.appearance().backgroundColor = .cream;
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
