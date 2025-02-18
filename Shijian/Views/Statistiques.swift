//
//  Statistiques.swift
//  Shijian
//
//  Created by colin cedric on 18/02/2025.
//

import SwiftUI

struct Statistiques: View {
    init() {
        UITabBar.appearance().isTranslucent = false;
        UITabBar.appearance().backgroundColor = .cream;
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            Text("Statistiques")
        }
    }
}

#Preview {
    Statistiques()
}
