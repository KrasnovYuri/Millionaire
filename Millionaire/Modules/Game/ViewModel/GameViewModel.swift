import SwiftUI
import SoundManager
import Questions

enum GameState {
    case lose
    case win
    case `default`
}

protocol GameViewModelProtocol: ObservableObject {
    var currentQuestion: Question? { get }
    func fetchNewQuestion(isNewGame: Bool)
    func answerQuestion(isRight: Bool)
}

final class GameViewModel {
    @Published var isWaiting = false
    @Published var sholdShowStatScreen = false
    @Published var gameState: GameState = .default
    @Published var currentTime: Int
    @Published var currentQuestion: Question?
    @Published var currentStat: StatQuestion
    @Published var enabledHelers: [Helper] = [
        .init(type: .fifty, isEnable: true),
        .init(type: .hall, isEnable: true),
        .init(type: .friend, isEnable: true),
        .init(type: .warning, isEnable: true),
    ]
    
    let maxHelpersCount: Int = 4
    private let questionStorage: QuestionStorageProtocol = QuestionStorage()
    private let questionManager: QuestionManagerProtocol
    private let maxTimeLimit = 30
    private var timer: Timer?
    private let soundManagaer = SoundManager.shared
    private var currentSound: SoundType?
    
    init() {
        self.questionManager = QuestionManager(questionStorage: questionStorage)
        currentStat = .one
        self.currentTime = maxTimeLimit
    }
}

extension GameViewModel: GameViewModelProtocol {
    func fetchNewQuestion(isNewGame: Bool) {
        isWaiting = false
        soundManagaer.play(.timer)
        currentSound = .startGame
        currentQuestion = questionManager.fetchNewQuestion(current: currentStat)
        startTimer()
        if !isNewGame {
            currentStat = StatQuestion(rawValue: currentStat.rawValue + 1) ?? .one
        }
    }
    
    func answerQuestion(isRight: Bool) {
        isWaiting = true
        soundManagaer.play(.pauseUntilResult)
        timer?.invalidate()
        guard isRight else {
            withDelay(delay: 2, action: { [weak self] in
                self?.soundManagaer.play(.incorrect)
                self?.isWaiting = false
                self?.gameState = .lose
            })
            return
        }
        withDelay(delay: 2, action: { [weak self] in
            guard let `self` else { return }
            soundManagaer.play(.correct)
            isWaiting = false
            currentTime = maxTimeLimit
            if currentStat == StatQuestion.allCases.last {
                gameState = .win
            } else {
                sholdShowStatScreen = true
            }
        })
    }
    
    func tapHelp(_ helper: Helper) {
        guard var answers = currentQuestion?.answers else { return }
                
        var indices = answers.enumerated()
            .filter { !$0.element.isRight }
            .map { $0.offset }
        indices.shuffle()
        
        let updateAnswers: (Int) -> Void = { index in
            answers[index] = Answer(number: index, title: "", isRight: false)
        }
        
        switch helper.type {
        case .fifty:
            indices.prefix(2).forEach(updateAnswers)
        case .hall, .friend:
            indices.forEach(updateAnswers)
        case .warning:
            if let index = indices.first {
                updateAnswers(index)
            }
        }
        
        self.currentQuestion?.answers = answers
        
        if let helpIndex = enabledHelers
            .firstIndex(where: { $0.type == helper.type }) {
            var newHelper = helper
            newHelper.isEnable = false
            enabledHelers[helpIndex] = newHelper
        }
    }
}

private extension GameViewModel {
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                                     block: { [weak self] timer in
            guard let `self` else { return }
            guard currentTime > .zero else {
                gameState = .lose
                timer.invalidate()
                return
            }
            self.currentTime -= 1
        })
    }
    
    func withDelay(delay: Double, action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: action)
    }
}
