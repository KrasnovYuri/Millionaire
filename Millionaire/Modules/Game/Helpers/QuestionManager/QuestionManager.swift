import Foundation
import Questions

protocol QuestionManagerProtocol {
    var questionCount: Int { get }
    func fetchNewQuestion(current question: Int) -> Question?
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

// MARK: - Implementation

extension QuestionManager: QuestionManagerProtocol {
    var questionCount: Int {
        questions.count
    }
    
    func fetchNewQuestion(current question: Int) -> Question? {
        guard question < maxLimitOffset else { return nil }
        guard !questions.isEmpty else { return obtainQuestions(offset: question) }
        return questions.dequeue()
    }
}

private extension QuestionManager {
    func obtainQuestions(offset: Int) -> Question? {
        let level = obtainLevel(offset)
        questionStorage.fetchQuestion(for: level) { [weak self] questions in
            guard let `self`, questions.count > maxCountQuestionsInLevel else { return }
            let firstFiveQuestions = Array(questions.prefix(maxCountQuestionsInLevel))
            firstFiveQuestions.forEach { self.questions.enqueue($0) }
        }
        return self.questions.dequeue()
    }
    
    func obtainLevel(_ offset: Int) -> QuestionLevel {
        switch offset {
        case 0...4:
            return .low
        case 5...9:
            return .medium
        case 10...14:
            return .high
        default:
            return .low
        }
    }
}
