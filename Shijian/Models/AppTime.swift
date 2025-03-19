//
//  AppTime.swift
//  Shijian
//
//  Created by colin cedric on 11/03/2025.
//

import Foundation

struct AppTime: Identifiable {
    var id = UUID()
    var date: Date
    /**
            Temps en secondes
     */
    var time: Int

}
