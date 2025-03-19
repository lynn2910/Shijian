//
//  AppStatsCard.swift
//  Shijian
//
//  Created by colin cedric on 19/03/2025.
//

import SwiftUI

struct AppStatsCard: View {
    var progressPercentage: Double
    var time: String
    var name: String
    var appInfo: AppInfo
    
    @State private var isDetailViewPresented = false
    
    var body: some View {
        Button(action: {
            isDetailViewPresented.toggle()
        }) {
            HStack {
                Image("instagram")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                VStack(spacing: 4) {
                    // head
                    HStack {
                        Text("\(time) - \(name)")
                            .font(.title3)
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .foregroundColor(.black)
                    }
                    
                    // progress
                    ProgressView(value: progressPercentage)
                }
            }.padding(.horizontal)
        }.sheet(isPresented: $isDetailViewPresented) {
            AppDetailView(appInfo: appInfo)
        }
    }
}

#Preview {
    AppStatsCard(
        progressPercentage: 0.7, time: "14h 58m", name: "Instagram", appInfo: AppInfo.testData.first!
    )
}
