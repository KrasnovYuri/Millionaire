import XCTest
import Questions
@testable import Millionaire

final class MillionaireTests: XCTestCase {
    private var storage: QuestionStorageProtocol!
    private var questionManager: QuestionManagerProtocol!
    
    private let maxQuestionCount = 5
    private var currentOffset: Int!
    
    override func setUp() {
        super.setUp()
        currentOffset = 0
        storage = QuestionStorage()
        questionManager = QuestionManager(questionStorage: storage)
    }

    override func tearDown() {
        currentOffset = nil
        storage = nil
        questionManager = nil
        super.tearDown()
    }
    
    func testStartGameQuestionExist() {
        let first = questionManager.fetchNewQuestion(current: currentOffset)
        currentOffset += 1
        XCTAssertEqual(questionManager.questionCount, 4)
    }
    
    func testQuestionsIsEmpty() {
        passQuestions(number: maxQuestionCount)
        XCTAssertEqual(questionManager.questionCount, 0)
    }
    
    func testCurrentLevel() {
        passQuestions(number: maxQuestionCount - 1)
        let lastQuestion = questionManager.fetchNewQuestion(current: currentOffset)
        XCTAssertEqual(lastQuestion?.level, .low)
    }
    
    func testObtainNewLevel() {
        passQuestions(number: maxQuestionCount)
        let six = questionManager.fetchNewQuestion(current: currentOffset)!
        XCTAssertEqual(six.level, .medium)
    }
    
    func testMediumLevel() {
        passQuestions(number: 9)
        let tenQuestion = questionManager.fetchNewQuestion(current: currentOffset)!
        XCTAssertEqual(tenQuestion.level, .medium)
    }
    
    func testHightLevel() {
        passQuestions(number: 10)
        let elevenQuestion = questionManager.fetchNewQuestion(current: currentOffset)!
        XCTAssertEqual(elevenQuestion.level, .high)
    }
    
    func testNilQuestion() {
        passQuestions(number: 15)
        let nilQuestion = questionManager.fetchNewQuestion(current: currentOffset)
        XCTAssertNil(nilQuestion)
    }
}

private extension MillionaireTests {
    func passQuestions(number: Int) {
        for _ in 0..<number {
            let question = questionManager.fetchNewQuestion(current: currentOffset)
            currentOffset += 1
        }
    }
}
