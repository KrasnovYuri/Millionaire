import Foundation

struct Helper {
    let type: HelpType
    var isEnable: Bool
}

enum HelpType {
    case fifty
    case hall
    case friend
    case warning
    
    var imageName: String {
        switch self {
        case .fifty:
            return "helpIcon1"
        case .hall:
            return "helpIcon2"
        case .friend:
            return "helpIcon3"
        case .warning:
            return "helpIcon4"
        }
    }
}

extension HelpType: Equatable {
    static func ==(lhs: HelpType, rhs: HelpType) -> Bool {
        return lhs.imageName == rhs.imageName
    }
}
