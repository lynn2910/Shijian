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
                VStack(alignment: .leading) {
                    Text("591")
                        .font(.system(size: 54, weight: .bold, design: .default))
                    
                    Text("jours de série").bold()
                }
                
                Spacer()
                
                Image("flame")
            }.padding()
        
            Spacer()
            
            HStack {
                Text("Calendrier des séries")
                    .bold()
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }.padding(.horizontal)
            
            Spacer().frame(height: 10)
            
            SeriesCalendar().padding(.horizontal)
            
            Text("Votre série sera réinitialisée si vous dépassez une limite quotidienne")
                .font(.caption)
                .padding()
        }
    }
}

#Preview {
    ZStack {
        BackgroundView()
        Statistiques()
    }
}
