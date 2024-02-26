import Foundation

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
