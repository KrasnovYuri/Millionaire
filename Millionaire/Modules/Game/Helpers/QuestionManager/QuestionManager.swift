import Foundation
import Questions

protocol QuestionManagerProtocol {
    var questionCount: Int { get }
    func fetchNewQuestion(current stat: StatQuestion) -> Question?
}

final class QuestionManager {
    private let maxCountQuestionsInLevel = 5
    private let maxLimitOffset = 15
    private let questionStorage: QuestionStorageProtocol
    private var questions = Queue<Question>()
    
    init(questionStorage: QuestionStorageProtocol) {
        self.questionStorage = questionStorage
    }
}

// MARK: - Public

extension QuestionManager: QuestionManagerProtocol {
    var questionCount: Int {
        questions.count
    }
    
    func fetchNewQuestion(current stat: StatQuestion) -> Question? {
        guard stat.rawValue < maxLimitOffset else { return nil }
        guard !questions.isEmpty else { return obtainQuestions(stat: stat) }
        return questions.dequeue()
    }
}

// MARK: - Implementation

private extension QuestionManager {
    func obtainQuestions(stat: StatQuestion) -> Question? {
        questionStorage.fetchQuestion(for: stat.level) { [weak self] questions in
            guard let `self`, questions.count > maxCountQuestionsInLevel else { return }
            let firstFiveQuestions = Array(questions.prefix(maxCountQuestionsInLevel))
            firstFiveQuestions.forEach { self.questions.enqueue($0) }
        }
        return self.questions.dequeue()
    }
}
