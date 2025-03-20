
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
    
    func getTimesInPeriod(app: AppInfo) -> [AppTime] {
        // TODO ne fonctionne pas??
        switch (selectedPeriod) {
            case .today:
                let today = Calendar.current.startOfDay(for: Date())
                return app.times
                    .filter { Calendar.current.isDate($0.date, inSameDayAs: today) }
            case .last7Days:
                let today = Date()
                let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: today)!
            
                return app.times
                    .filter { $0.date >= sevenDaysAgo && $0.date <= today }
            case .lastMonth:
                let today = Date()
                let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: today)!
    
                return app.times
                    .filter { $0.date >= oneMonthAgo && $0.date <= today }
            case .last12Months:
                let today = Date()
                let twelveMonthsAgo = Calendar.current.date(byAdding: .year, value: -1, to: today)!
    
                return app.times
                    .filter { $0.date >= twelveMonthsAgo && $0.date <= today }
        }
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
                    let filteredApps = appsVM.apps.filter { !getTimesInPeriod(app: $0).isEmpty }
                                        
                    if filteredApps.isEmpty {
                        Text("Aucune application utilisée dans cette période")
                    } else {
                        ForEach(filteredApps) { app in
                            AppCardView(
                                app: app,
                                times: getTimesInPeriod(app: app),
                                period: selectedPeriod
                            )
                        }
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
