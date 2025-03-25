//
//  ContentView.swift
//  Shijian
//
//  Created by colin cedric on 18/02/2025.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().isTranslucent = false;
        UITabBar.appearance().backgroundColor = .cream;
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Accueil", systemImage: "house")
                }
            Statistiques()
                .tabItem {
                    Label("Statistiques", systemImage: "chart.bar.fill")
                }
            Settings()
                .tabItem {
                    Label("Paramètres", systemImage: "gearshape.fill")
                }
        }.shadow(color: Color.gray.opacity(0.2), radius: 30)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppsViewModel())
}
