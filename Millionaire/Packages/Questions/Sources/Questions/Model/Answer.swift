import Foundation

public struct Answer: Codable {
    let number: Int
    let title: String
    let isRight: Bool
    
    enum CodingKeys: String, CodingKey {
        case number, title
        case isRight = "is_right"
    }
}

extension Answer: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
