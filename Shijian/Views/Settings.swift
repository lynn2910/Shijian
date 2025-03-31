//
//  Settings.swift
//  Shijian
//
//  Created by colin cedric on 18/02/2025.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var appsVM: AppsViewModel
    
    @State var isTimeSelectionVisible = false
    
    var formattedSelectedTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated

        guard let limiterTime = appsVM.globalTimer else {
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
        @State var selectedTime = appsVM.globalTimer ?? Date.init(timeIntervalSince1970: 0);

        ZStack {
            BackgroundView()
            
            VStack {
                Text("Paramètres")
                    .font(.title)
                    .bold()
                
                HStack {
                    Button {
                        isTimeSelectionVisible.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "hourglass")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 25, height: 25)

                            VStack(alignment: .leading) {
                                Text("Minuteur global").bold()
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
                        appsVM.setGlobalTimer(timer: Date.init(timeIntervalSince1970: 0))
                    } label: {
                        Image(systemName: "trash.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.black)
                    }
                    Spacer(minLength: 1)
                }
                
                Spacer()
            }.padding(.vertical)
        }
        .sheet(isPresented: $isTimeSelectionVisible) {
            NavigationView {
                VStack {
                    DatePicker("Please enter a time", selection: $selectedTime, displayedComponents: .hourAndMinute).padding()
                    
                    Spacer(minLength: 10)
                    Button {
                        appsVM.setGlobalTimer(timer: selectedTime)
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
    Settings().environmentObject(AppsViewModel())
}
