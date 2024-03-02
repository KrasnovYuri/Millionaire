import SwiftUI

//Экран результата игры (проиграл/нет) + палец 

//struct ResultView: View {
//    let cash: UInt
//    let isWin: Bool
//    
//    var body: some View {
//        Text(isWin ? "Win" : "Lose")
//    }
//}


struct ResultView: View {
    let earnedMoney: UInt
    let thumbs:String

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
                Image(thumbs)
                    .resizable()
                    .frame(width: 166, height: 166, alignment : .bottom)
                Button(action: {
                    // newGame
                }) {
                    Text("играть еще раз")
                        .foregroundColor(.white)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purple, lineWidth: 3)
                )
                Spacer()
            }
        }
    }
    
    init(earnedMoney: UInt) {
        self.earnedMoney = earnedMoney
        self.thumbs = earnedMoney >= 100 ? "winResultIcon" : "loseResultIcon"
    }
}

//#Preview {
//    ResultsView(earnedMoney: 100)
//}


