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
    
    @State var isTimeSelectionVisible = false
    
    var formattedSelectedTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated

        guard let limiterTime = appsVM.getCategoryLimit(category: ctg) else {
            return ""
        }

        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: limiterTime)

        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)

        if let dateWithTime = calendar.date(byAdding: components, to: startOfDay) {
            let interval = dateWithTime.timeIntervalSince(startOfDay)
            if interval <= 3600 { return "0h" }
            return formatter.string(from: interval) ?? ""
        } else {
            return ""
        }
    }
    
    var body: some View {
        @State var selectedTime = appsVM.getCategoryLimit(category: ctg) ?? Date.init(timeIntervalSince1970: 0);

        
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
            
            HStack {
                Spacer(minLength: 1)
                Button {
                    isTimeSelectionVisible.toggle()
                } label: {
                    HStack {
                        Image(systemName: "hourglass")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 25, height: 25)

                        VStack(alignment: .leading) {
                            Text("Minuteur de catégorie").bold()
                            HStack(alignment: .firstTextBaseline) {
                                Text(formattedSelectedTime)
                            }
                        }
                    }.padding(.horizontal)
                }.buttonStyle(PlainButtonStyle())
                
                
                Spacer()
                
                Rectangle()
                    .frame(width: 2, height: 30)
                    .padding(.horizontal, 50)
                
                Spacer()
                
                
                Button {
                    appsVM.changeCategoryLimit(category: ctg, newLimit: Date.init(timeIntervalSince1970: 0))
                } label: {
                    Image(systemName: "trash.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.black)
                }
                Spacer(minLength: 1)
            }
            
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
        .sheet(isPresented: $isTimeSelectionVisible) {
            NavigationView {
                VStack {
                    DatePicker("Please enter a time", selection: $selectedTime, displayedComponents: .hourAndMinute).padding()
                    
                    Spacer(minLength: 10)
                    Button {
                        appsVM.changeCategoryLimit(category: ctg, newLimit: selectedTime)
                        isTimeSelectionVisible.toggle()
                    } label: {
                        Text("Définir le nouveau temps")
                    }
                    
                    Spacer()
                }
                .navigationTitle("Sélectionner le temps")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Annuler") {
                            isTimeSelectionVisible.toggle()
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
