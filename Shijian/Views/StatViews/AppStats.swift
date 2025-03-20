
import SwiftUI
import Charts

struct AppStats: View {
    
    @State private var selectedPeriod: TimePeriod = .today
    @State private var test: Bool = false
    
    @EnvironmentObject var appsVM: AppsViewModel

    func formatTime(_ timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval / 3600)
        let minutes = Int((timeInterval.truncatingRemainder(dividingBy: 3600)) / 60)
        return String(format: "%dh %02dm", hours, minutes)
    }
    
    var body: some View {
        VStack {
            Spacer(minLength: 40)
            
            Text("Catégories")
                .font(.title)
            
            ScrollView {
                HStack(alignment: .firstTextBaseline) {
                    ForEach(AppCategory.allCases) { ctg in
                        AppCategoryView(ctg: ctg)
                    }
                }
            }
            .frame(height: 40, alignment: .center)
            
        
            
            Text("Applications")
                .font(.title)
            
            // Picker
            Picker("Période", selection: $selectedPeriod) {
                ForEach(TimePeriod.allCases) { period in
                    Text(period.rawValue).tag(period)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .padding(.top, 0)
            
            Spacer(minLength: 20)
            
            
            // Apps list
            ScrollView {
                VStack {
                    ForEach(AppInfo.testData) { app in
                        AppCardView(app: app, times: app.times)
                    }
                }
            }
        }
    }
}

#Preview {
    AppStats()
        .environmentObject(AppsViewModel())
}
