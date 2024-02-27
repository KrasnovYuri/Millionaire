import Foundation

public struct Question: Codable {
    let title: String
    let level: QuestionLevel
    let answers: [Answer]
}

extension Question: Equatable {
    public static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.title == rhs.title
    }
}

extension Question: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
