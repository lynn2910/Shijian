import SwiftUI

struct AppCategoryView: View {
    var ctg: AppCategory
    
    @State private var shouldOpenSheet: Bool = false
    
    var body: some View {
        Button {
            shouldOpenSheet.toggle()
        } label: {
            Text("\(ctg.rawValue)")
                .foregroundStyle(.white)
                .bold()
                .padding(.horizontal, 10)
                .background(.link)
                .cornerRadius(3)
        }.sheet(isPresented: $shouldOpenSheet) {
            CategorySheet(ctg: ctg, shouldOpenSheet: $shouldOpenSheet)
        }
    }
}

#Preview {
    AppCategoryView(ctg: .social)
}
