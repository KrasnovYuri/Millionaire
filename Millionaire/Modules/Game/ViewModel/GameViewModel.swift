import SwiftUI
import SoundManager
import Questions

protocol GameViewModelProtocol: ObservableObject {
    var currentQuestion: Question? { get }
    func startNewGame()
    func answerQuestion(isRight: Bool)
}

final class GameViewModel {
    @Published var isWaiting = false
    @Published var sholdShowStatScreen = false
    @Published var isLoser = false
    @Published var currentTime: Int
    @Published var currentQuestion: Question?
    @Published var currentStat: StatQuestion
    
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
    func startNewGame() {
        guard currentStat == .one else { return }
        isWaiting = false
        soundManagaer.delegate = self
        soundManagaer.play(.startGame)
        currentSound = .startGame
        currentQuestion = questionManager.fetchNewQuestion(current: currentStat)
        startTimer()
    }
    
    func answerQuestion(isRight: Bool) {
        isWaiting = true
        soundManagaer.play(.pauseUntilResult)
        timer?.invalidate()
        guard isRight else {
            withDelay(delay: 3, action: { [weak self] in
                self?.soundManagaer.play(.incorrect)
                self?.isWaiting = false
                self?.isLoser = true
            })
            return
        }
        currentTime = maxTimeLimit
        currentStat = StatQuestion(rawValue: currentStat.rawValue + 1) ?? .one
        withDelay(delay: 3, action: { [weak self] in
            guard let `self` else { return }
            soundManagaer.play(.correct)
            isWaiting = false
            sholdShowStatScreen = true
            currentQuestion = questionManager.fetchNewQuestion(current: currentStat)
            startTimer()
        })
    }
}

extension GameViewModel: SoundManagerDelegate {
    func didChangeSound(sound: SoundType) {
        self.currentSound = sound
    }
    
    func didFinishPlay() {
        guard let currentSound else { return }
        switch currentSound {
        case .timer:
            break
        case .start:
            break
        case .startGame:
            soundManagaer.play(.timer)
        case .incorrect:
            break
        case .pauseUntilResult:
            break
        case .correct:
            soundManagaer.play(.timer)
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
