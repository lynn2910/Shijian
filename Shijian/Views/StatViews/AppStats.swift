//
//  AppStats.swift
//  Shijian
//
//  Created by colin cedric on 18/02/2025.
//

import SwiftUI

struct AppStats: View {
    @EnvironmentObject var appsVM: AppsViewModel
    
    var body: some View {
        Text("Statistiques")
    }
}

#Preview {
    AppStats()
        .environmentObject(AppsViewModel())
}
