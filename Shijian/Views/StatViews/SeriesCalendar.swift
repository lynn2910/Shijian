//
//  SeriesCalendar.swift
//  Shijian
//
//  Created by colin cedric on 11/03/2025.
//

import SwiftUI

struct SeriesCalendar: View {
    let monthName = "Janvier";
    let daysOfWeek = ["Lun", "Mar", "Mer", "Jeu", "Ven", "Sam", "Dim"];
    let daysInMonth = 31 + 2;
    let firstDayOfMonth = 3;
    
    let invalidDays = [8, 11, 12]
    let daysInInvalidWeeks = [7,8,9,10,11,12,13]

    var body: some View {
        VStack {
            // titres du mois
            HStack {
                Button {
                    // action
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.black)
                }
                Spacer()
                Text(monthName)
                    .font(.title)
                Spacer()
                Button {
                    // action
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.black)
                }
            }.padding(.horizontal)
            
            // Jours de la semaine
            HStack {
                ForEach(daysOfWeek, id: \.self){ day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.gray)
                }
            }
            
            // Grille des jours du mois
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)) {
                ForEach(0..<firstDayOfMonth, id:\.self) { _ in
                    Text("")
                }
                
                ForEach(1...daysInMonth, id: \.self) { day in
                    let index = day + firstDayOfMonth - 1;
                    
                    let isInvalid = invalidDays.contains(index);
                    let isWeekInvalid = daysInInvalidWeeks.contains(index);
                    
                    let isStart = day == firstDayOfMonth || index % 7 == 0;
                    let isEnd = index % 7 == 6 || index == daysInMonth + 2;
                    
                    let backgroundColor: Color = isWeekInvalid ? Color.orange.opacity(0.3) : Color.orange;
                    
                    let dayNumber = "\(index)";
                    
                    
                    Text(dayNumber)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .background(
                            UnevenRoundedRectangle(
                                cornerRadii: .init(
                                    topLeading: isStart ? 25 : 0,
                                    bottomLeading: isStart ? 25 : 0,
                                    bottomTrailing: isEnd ? 25 : 0,
                                    topTrailing: isEnd ? 25 : 0
                                )
                            )
                            .fill(backgroundColor)
                        )
                        .overlay(
                            isInvalid ?
                            ZStack {
                                Circle()
                                    .fill(Color.cyan.opacity(0.75))
                                    .padding(4)
                                
                                Text(dayNumber)
                            }: nil
                        )
                        .padding(.vertical, 2)
                }
            }.padding(.horizontal)
        }
        .padding()
        .background(Color.cream)
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerSize: .init(width: 25, height: 25))
                .stroke(Color.black, lineWidth: 2)
        )
    }
}

#Preview {
    ZStack {
        BackgroundView()
        SeriesCalendar().padding()
    }
}
