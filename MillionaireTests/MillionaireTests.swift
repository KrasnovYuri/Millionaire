import XCTest
import Questions
@testable import Millionaire

final class MillionaireTests: XCTestCase {
    private var storage: QuestionStorageProtocol!
    private var questionManager: QuestionManagerProtocol!
    
    private let maxQuestionCount = 5
    private var currentOffset: Int!
    private var currentStat: StatQuestion!
    
    override func setUp() {
        super.setUp()
        currentOffset = 1
        currentStat = StatQuestion(rawValue: currentOffset)
        storage = QuestionStorage()
        questionManager = QuestionManager(questionStorage: storage)
    }

    override func tearDown() {
        currentOffset = nil
        storage = nil
        questionManager = nil
        currentStat = nil
        super.tearDown()
    }
    
    func testStartGameQuestionExist() {
        let question: StatQuestion = StatQuestion(rawValue: currentOffset)!
        _ = questionManager.fetchNewQuestion(current: question)
        currentOffset += 1
        XCTAssertEqual(questionManager.questionCount, 4)
    }
    
    func testQuestionsIsEmpty() {
        passQuestions(number: maxQuestionCount)
        XCTAssertEqual(questionManager.questionCount, 0)
    }
    
    func testCurrentLevel() {
        passQuestions(number: maxQuestionCount - 1)
        let lastQuestion = questionManager.fetchNewQuestion(current: currentStat)
        XCTAssertEqual(lastQuestion?.level, .low)
    }
    
    func testObtainNewLevel() {
        passQuestions(number: maxQuestionCount)
        let six = questionManager.fetchNewQuestion(current: currentStat)!
        XCTAssertEqual(six.level, .medium)
    }
    
    func testMediumLevel() {
        passQuestions(number: 9)
        let tenQuestion = questionManager.fetchNewQuestion(current: currentStat)!
        XCTAssertEqual(tenQuestion.level, .medium)
    }
    
    func testHightLevel() {
        passQuestions(number: 10)
        let elevenQuestion = questionManager.fetchNewQuestion(current: currentStat)!
        XCTAssertEqual(elevenQuestion.level, .high)
    }
    
    func testNilQuestion() {
        XCTAssertNil(StatQuestion(rawValue: 16))
    }
}

private extension MillionaireTests {
    func passQuestions(number: Int) {
        for _ in 0..<number {
            let stat: StatQuestion = StatQuestion(rawValue: currentOffset)!
            _ = questionManager.fetchNewQuestion(current: stat)
            currentOffset += 1
        }
    }
}
