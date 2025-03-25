//
//  CategorySheet.swift
//  Shijian
//
//  Created by colin cedric on 20/03/2025.
//

import SwiftUI
import Charts

struct CategorySheet: View {
    var ctg: AppCategory
    
    @Binding var shouldOpenSheet: Bool
    @EnvironmentObject var appsVM: AppsViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            // header
            HStack {
                Spacer()
                
                Text("\(ctg.rawValue)")
                    .font(.title2)
                    .bold()
                    .padding(.leading, 60)
                
                Spacer()
                
                Button {
                    shouldOpenSheet.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.all, 20)
                        .foregroundColor(.black)
                }
            }
            
            let apps = appsVM.apps.filter { $0.category == ctg }
            
            // Camembert
            Chart(apps.map { $0.toUsageData() }) { item in
                SectorMark(
                    angle: .value("Temps d'utilisation", item.totalTime),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Application", item.app.name))
            }
            .chartLegend(position: .trailing, alignment: .center)
            .padding(.all, 25)
            .frame(height: 200)
            
            // liste
            ScrollView {
                VStack {
                    if apps.isEmpty {
                        Text("Aucune application utilisée dans cette période")
                    } else {
                        ForEach(apps) { app in
                            AppCardView(
                                app: app,
                                times: app.times,
                                period: .last12Months
                            )
                        }
                    }
                }
            }
            
        }
    }
}



#Preview {
    @State var toggle: Bool = true
    
    return CategorySheet(ctg: .social, shouldOpenSheet: $toggle)
        .environmentObject(AppsViewModel())
}
