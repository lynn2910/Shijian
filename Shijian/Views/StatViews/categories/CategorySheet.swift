//
//  CategorySheet.swift
//  Shijian
//
//  Created by colin cedric on 20/03/2025.
//

import SwiftUI

struct CategorySheet: View {
    var ctg: AppCategory
    
    @Binding var shouldOpenSheet: Bool
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}



#Preview {
    @State var toggle: Bool = true
    
    return CategorySheet(ctg: .social, shouldOpenSheet: $toggle)
        .environmentObject(AppsViewModel())
}
