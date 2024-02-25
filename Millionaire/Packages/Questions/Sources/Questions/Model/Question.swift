import Foundation

public struct Question: Codable {
    let title: String
    let level: QuestionLevel
    let answers: [Answer]
}

public struct Answer: Codable {
    let number: Int
    let title: String
    let isRight: Bool
    
    enum CodingKeys: String, CodingKey {
        case number, title
        case isRight = "is_right"
    }
}

public enum QuestionLevel: Int, CaseIterable, Codable {
    case low
    case medium
    case high
    
    var jsonName: String {
        switch self {
        case .low:
            return "low_questions"
        case .medium:
            return "medium_questions"
        case .high:
            return "high_questions"
        }
    }
}
