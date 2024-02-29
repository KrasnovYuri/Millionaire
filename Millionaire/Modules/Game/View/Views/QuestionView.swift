import SwiftUI

struct QuestionView: View {
    let title: String
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .regular))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(minHeight: 80)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(LinearGradient(
                        colors: [Color(hex: 0x14144C), Color(hex: 0x2D1158)],
                        startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
            )
    }
}
