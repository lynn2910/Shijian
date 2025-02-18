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
    
    
    @State private var selection = 0;
    
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Picker("Options", selection: $selection) {
                    Text("Série").tag(0)
                    Text("Statistiques").tag(1)
                }.pickerStyle(.segmented)
                    .padding(.horizontal)
                
                Spacer()
                
                if selection == 0 {
                    SeriesStats()
                } else {
                    AppStats()
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    Statistiques()
}
