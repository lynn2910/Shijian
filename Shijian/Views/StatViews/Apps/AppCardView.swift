//
//  AppCardView.swift
//  Shijian
//
//  Created by colin cedric on 20/03/2025.
//

import SwiftUI

struct AppCardView: View {
    var app: AppInfo
    var times: [AppTime]
    
    @State private var isDetailViewPresented = false
    
    func formatTime(_ timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval / 3600)
        let minutes = Int((timeInterval.truncatingRemainder(dividingBy: 3600)) / 60)
        return String(format: "%dh", hours, minutes)
    }
    
    
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
                        let totalTimeSeconds = times.reduce(0) { $0 + $1.time }
                        
                        Text("\(formatTime(TimeInterval(totalTimeSeconds)))")
                            .foregroundStyle(.black)
                            .font(.title3)
                            .frame(width: 50)
                        
                        
                        Text("\(app.name)")
                            .font(.title3)
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .foregroundColor(.black)
                    }
                    
                    // progress
                    //ProgressView(value: progressPercentage)
                }
            }.padding(.horizontal)
        }.sheet(isPresented: $isDetailViewPresented) {
            Text("hello!")
        }
    }
}

#Preview {
    AppCardView(
        app: AppInfo.testData.first!,
        times: AppInfo.testData.first!.times
    )
}
