import SwiftUI

struct AppDetailsView: View {
    var app: AppInfo
    var times: [AppTime]
    var period: TimePeriod
    
    @Binding var shouldOpenSheet: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                
                Text("\(app.name)")
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
            
            Spacer()
        }
    }
}

#Preview {
    @State var shouldOpenSheet: Bool = false
    
    return AppDetailsView(
        app: AppInfo.testData.first!,
        times: AppInfo.testData.first!.times,
        period: .last12Months,
        shouldOpenSheet: $shouldOpenSheet
    )
}
