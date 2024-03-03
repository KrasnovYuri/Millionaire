import XCTest
@testable import Questions

final class QuestionsTests: XCTestCase {
    let questionStorage: QuestionStorageProtocol = QuestionStorage()
    var lowQuestion = [Question]()
    var mediumQuestion = [Question]()
    var highQuestion = [Question]()
    var answersCount = 4
    var notRightAnswersCount = 3
    var allQuestions: [Question] {
        lowQuestion + mediumQuestion + highQuestion
    }
    
    override func setUp() {
        questionStorage.fetchQuestion(for: .low) { [weak self] questions in
            self?.lowQuestion = questions
        }
        
        questionStorage.fetchQuestion(for: .medium) { [weak self] questions in
            self?.mediumQuestion = questions
        }
        
        questionStorage.fetchQuestion(for: .high) { [weak self] questions in
            self?.highQuestion = questions
        }
    }
    
    func testIsNotEmpty() {
        XCTAssertFalse(lowQuestion.isEmpty || mediumQuestion.isEmpty || highQuestion.isEmpty)
    }
    
    func testLowQuestions() {
        lowQuestion.forEach({
            XCTAssertTrue($0.level == .low)
        })
    }
    
    func testMediumQuestions() {
        mediumQuestion.forEach({
            XCTAssertTrue($0.level == .medium)
        })
    }
    
    func testHighQuestions() {
        highQuestion.forEach({
            XCTAssertTrue($0.level == .high)
        })
    }
    
    func testCountAnswers() {
        allQuestions.forEach({
            XCTAssertTrue($0.answers.count == answersCount)
        })
    }
    
    func testEqutable() {
        let questionSet: Set<Question> = Set(allQuestions)
        XCTAssertTrue(questionSet.count == allQuestions.count)
    }
    
    func testContainRightAnswer() {
        allQuestions.forEach({
            XCTAssertTrue($0.answers.contains(where: { $0.isRight == true }))
        })
    }
    
    func testNotRightAnswersCount() {
        allQuestions.forEach({
            let notRight = $0.answers.filter({ $0.isRight == false }).count
            XCTAssertTrue(notRight == notRightAnswersCount)
        })
    }
    
    func testAnswersIsNotEmpty() {
        let allAnswers = allQuestions.flatMap({ $0.answers })
        allAnswers.forEach({
            XCTAssertFalse($0.title.isEmpty)
        })
    }
}
