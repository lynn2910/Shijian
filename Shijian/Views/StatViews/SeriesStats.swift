//
//  SeriesStats.swift
//  Shijian
//
//  Created by colin cedric on 18/02/2025.
//

import SwiftUI

struct SeriesStats: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("591")
                        .font(.system(size: 54, weight: .bold, design: .default))
                    
                    Text("jours de série").bold()
                }
                
                Spacer()
                
                Image("flame")
                Spacer()
            }
            
            Text("Calendrier")
        }
    }
}

#Preview {
    ZStack {
        BackgroundView()
        SeriesStats()
    }
}
