import SwiftUI
import SoundManager
import Questions

struct GameView: View {
    @State private var showingStats = false
    @State private var opacity = 0.0
    @ObservedObject private var viewModel = GameViewModel()
    let username: String
    
    var body: some View {
        switch viewModel.gameState {
        case .lose:
            ResultView(earnedMoney: viewModel.currentStat.price, isWin: false)
        case .win:
            ResultView(earnedMoney: viewModel.currentStat.price, isWin: true)
        case .default:
            MainGameView(viewModel: viewModel, didAnswer: { isRight in
                answerQuestion(isRight: isRight)
            })
            .disabled(viewModel.isWaiting)
            .opacity(opacity)
            .onAppear{
                viewModel.fetchNewQuestion(isNewGame: true)
                withAnimation(.easeInOut(duration: 2)) {
                    opacity = 1
                }
            }.sheet(isPresented: $viewModel.sholdShowStatScreen, onDismiss: {
                viewModel.fetchNewQuestion(isNewGame: false)
            }, content: {
                CurrentStats(currentQuestion: viewModel.currentStat)
            })
        }
    }
}

private extension GameView {
    func answerQuestion(isRight: Bool) {
        viewModel.answerQuestion(isRight: isRight)
    }
}
