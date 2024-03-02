import SwiftUI
import SoundManager
import Questions

struct GameView: View {
    @State private var showingStats = false
    @State private var opacity = 0.0
    @ObservedObject private var viewModel = GameViewModel()
    let username: String
    
    var body: some View {
        if !viewModel.isLoser {
            MainGameView(viewModel: viewModel, didAnswer: { isRight in
                answerQuestion(isRight: isRight)
            })
            .disabled(viewModel.isWaiting)
            .opacity(opacity)
            .onAppear{
                viewModel.fetchNewQuestion()
                withAnimation(.easeInOut(duration: 2)) {
                    opacity = 1
                }
            }.sheet(isPresented: $viewModel.sholdShowStatScreen, onDismiss: {
                viewModel.fetchNewQuestion()
            }, content: {
                CurrentStats()
            })
        } else {
            ResultView(earnedMoney: viewModel.currentStat.price, isWin: false)
        }
    }
}

private extension GameView {
    func answerQuestion(isRight: Bool) {
        viewModel.answerQuestion(isRight: isRight)
    }
}
