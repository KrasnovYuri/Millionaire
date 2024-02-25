import SwiftUI

struct GradientBackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [Color(hex: 0x06061C),
                         Color(hex: 0x170A34)]
            ),
            startPoint: .leading,
            endPoint: .trailing
        )
        .edgesIgnoringSafeArea(.all)
    }
}
