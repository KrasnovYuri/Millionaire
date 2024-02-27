import SwiftUI
import Questions

protocol GameViewModelProtocol {
    func startNewGame()
}

final class GameViewModel: ObservableObject {
    private var currentQuestion = 1
    private var currentSum = 0
    
}

extension GameViewModel: GameViewModelProtocol {
    func startNewGame() {
        currentQuestion = 1
        currentSum = 0
    }
}
