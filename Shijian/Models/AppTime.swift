import Foundation

struct AppTime: Identifiable {
    var id = UUID()
    var date: Date
    /**
            Temps en secondes
     */
    var time: Int

}
