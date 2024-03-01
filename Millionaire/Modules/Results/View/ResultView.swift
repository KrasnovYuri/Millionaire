import SwiftUI

//Экран результата игры (проиграл/нет) + палец 

struct ResultView: View {
    let cash: UInt
    let isWin: Bool
    
    var body: some View {
        Text(isWin ? "Win" : "Lose")
    }
}

