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
                
                Text("bip")
                
                GIFImage(name: "angry.gif")
                    .frame(width:200,height:200)
                
                Text("Yeet")
                
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
