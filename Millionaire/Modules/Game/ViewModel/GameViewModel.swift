import SwiftUI
import Questions

protocol GameViewModelProtocol: ObservableObject {
    var currentQuestion: Question? { get }
    func startNewGame()
    func newQuestion()
}

final class GameViewModel {
    @Published var currentQuestion: Question?
    @Published var currentStat: StatQuestion
    
    private let questionStorage: QuestionStorageProtocol = QuestionStorage()
    private let questionManager: QuestionManagerProtocol
    
    init() {
        self.questionManager = QuestionManager(questionStorage: questionStorage)
        currentStat = .one
    }
}

extension GameViewModel: GameViewModelProtocol {
    func startNewGame() {
        guard currentStat == .one else { return }
        currentQuestion = questionManager.fetchNewQuestion(current: currentStat)
    }
    
    func newQuestion() {
        guard let currentQuestion else { return }
        currentStat = StatQuestion(rawValue: currentStat.rawValue + 1) ?? .one
        self.currentQuestion = questionManager.fetchNewQuestion(current: currentStat)
    }
}
