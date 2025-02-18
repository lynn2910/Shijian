//
//  HomeView.swift
//  Shijian
//
//  Created by colin cedric on 18/02/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Spacer()
                
                Text("Tu as passé...")
                Text("5 h et 41 min")
                    .fontWeight(.black).font(.title)
                Text("sur ton téléphone aujourd'hui")
                
                //
                // Rapport
                //
                HStack(spacing: 20) {
                    VStack {
                        Text("Par rapport à hier").fontWeight(.medium)
                        Text("+ 3h 21m").bold()
                    }.padding(.all)
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: 3, height: 80)
                    VStack {
                        Text("Temps restant").fontWeight(.medium)
                        Text("19m").bold()
                    }.padding(.all)
                }
                    .frame(height:80)
                    .background {
                        Rectangle()
                            .foregroundColor(.white.opacity(0.7))
                            .border(.white, width: 2)
                            .cornerRadius(10)
                    }
                
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
