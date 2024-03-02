import SwiftUI
import SoundManager
import Questions

protocol GameViewModelProtocol: ObservableObject {
    var currentQuestion: Question? { get }
    func fetchNewQuestion()
    func answerQuestion(isRight: Bool)
}

final class GameViewModel {
    @Published var isWaiting = false
    @Published var sholdShowStatScreen = false
    @Published var isLoser = false
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
    func fetchNewQuestion() {
        isWaiting = false
        soundManagaer.delegate = self
        soundManagaer.play(.timer)
        currentSound = .startGame
        currentQuestion = questionManager.fetchNewQuestion(current: currentStat)
        startTimer()
    }
    
    func answerQuestion(isRight: Bool) {
        isWaiting = true
        soundManagaer.play(.pauseUntilResult)
        timer?.invalidate()
        guard isRight else {
            withDelay(delay: 2, action: { [weak self] in
                self?.soundManagaer.play(.incorrect)
                self?.isWaiting = false
                self?.isLoser = true
            })
            return
        }
        withDelay(delay: 2, action: { [weak self] in
            guard let `self` else { return }
            soundManagaer.play(.correct)
            isWaiting = false
            sholdShowStatScreen = true
            currentStat = StatQuestion(rawValue: currentStat.rawValue + 1) ?? .one
            currentTime = maxTimeLimit
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

extension GameViewModel: SoundManagerDelegate {
    func didChangeSound(sound: SoundType) {
        self.currentSound = sound
    }
    
    func didFinishPlay() {
        guard let currentSound else { return }
        switch currentSound {
        case .timer, .start, .startGame, .incorrect, .pauseUntilResult, .correct:
            break
        }
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
    
    func withDelay(delay: Double, action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: action)
    }
}
