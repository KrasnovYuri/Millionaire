import SwiftUI

struct StartView: View {
    var body: some View {
        ZStack {
            GradientBackgroundView()
            
            HStack {
                Text("Hello")
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    StartView()
}
