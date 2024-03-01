import SwiftUI
import Questions

protocol GameViewModelProtocol: ObservableObject {
    var currentQuestion: Question? { get }
    func startNewGame()
    func answerQuestion(isRight: Bool)
}

final class GameViewModel {
    @Published var isLoser = false
    @Published var currentTime: Int
    @Published var currentQuestion: Question?
    @Published var currentStat: StatQuestion
    
    private let questionStorage: QuestionStorageProtocol = QuestionStorage()
    private let questionManager: QuestionManagerProtocol
    private let maxTimeLimit = 30
    private var timer: Timer?
    
    init() {
        self.questionManager = QuestionManager(questionStorage: questionStorage)
        currentStat = .one
        self.currentTime = maxTimeLimit
    }
}

extension GameViewModel: GameViewModelProtocol {
    func startNewGame() {
        guard currentStat == .one else { return }
        currentQuestion = questionManager.fetchNewQuestion(current: currentStat)
        startTimer()
    }
    
    func answerQuestion(isRight: Bool) {
        timer?.invalidate()
        guard isRight else {
            isLoser = true
            return
        }
        currentTime = maxTimeLimit
        currentStat = StatQuestion(rawValue: currentStat.rawValue + 1) ?? .one
        self.currentQuestion = questionManager.fetchNewQuestion(current: currentStat)
        startTimer()
    }
}

private extension GameViewModel {
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                                     block: { [weak self] timer in
            guard let `self` else { return }
            guard currentTime > .zero else {
                isLoser = true
                timer.invalidate()
                return
            }
            self.currentTime -= 1
        })
    }
}
