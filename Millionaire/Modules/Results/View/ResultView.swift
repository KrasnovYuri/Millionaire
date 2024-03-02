import SwiftUI

struct ResultView: View {
    @State private var startNewGame = false
    let earnedMoney: UInt
    let isWin: Bool
    
    var body: some View {
        ZStack {
            GradientBackgroundView()
            VStack {
                Image(.logoLarge)
                    .resizable()
                    .frame(width: 251, height: 259, alignment : .bottom)
                    .scaledToFit()
                Spacer()
                Text("ИГРА ОКОНЧЕНА")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                Text("Ваш выигрыш: \(earnedMoney) ₽")
                    .foregroundStyle(.white)
                    .font(.headline.bold())
                Image(isWin ? "winResultIcon" : "loseResultIcon")
                    .resizable()
                    .frame(width: 166, height: 166, alignment : .bottom)
                Button(action: {
                    startNewGame = true
                }) {
                    Text("играть еще раз")
                        .foregroundColor(.white)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purple, lineWidth: 3)
                )
                .fullScreenCover(isPresented: $startNewGame, content: {
                    StartView()
                })
                Spacer()
            }
        }
    }
}
