import Foundation

public struct Answer: Codable {
    public let number: Int
    public let title: String
    public let isRight: Bool
    
    public init(number: Int, title: String, isRight: Bool) {
        self.number = number
        self.title = title
        self.isRight = isRight
    }
    
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
