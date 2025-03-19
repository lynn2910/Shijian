//
//  AppDetailView.swift
//  Shijian
//
//  Created by colin cedric on 19/03/2025.
//

import SwiftUI
import Charts

struct AppDetailView: View {
    var appInfo: AppInfo

    func formatTime(_ timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval / 3600)
        let minutes = Int((timeInterval.truncatingRemainder(dividingBy: 3600)) / 60)
        return String(format: "%dh", hours, minutes)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    // Fermer la vue détaillée
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            Image("instagram") // Remplacez par l'image appropriée
                .resizable()
                .frame(width: 100, height: 100)

            Text("\(formatTime(TimeInterval(appInfo.times.reduce(0) { $0 + $1.time })))")
                .font(.title)

            Text("Aujourd'hui")

            Chart(appInfo.times) { time in
                BarMark(
                    x: .value("Date", time.date, unit: .day),
                    y: .value("Temps", time.time)
                )
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .day)) { value in
                    AxisValueLabel(format: .dateTime.hour())
                }
            }
            .chartYAxis {
                AxisMarks { value in
                    if let timeInterval = value.as(TimeInterval.self) {
                        AxisValueLabel {
                            Text(formatTime(timeInterval))
                        }
                    }
                }
            }
            .padding()

            Spacer()
        }
        .padding()
    }
}
