import Foundation
import Questions

enum StatQuestion: Int, CaseIterable {
    case one = 1, second, third, fourth, fifth
    case sixth, seventh, eighth, ninth, tenth
    case eleventh, twelfth, thirteenth, fourteenth, fifteenth
    
    var level: QuestionLevel {
        switch self {
        case .one, .second, .third, .fourth, .fifth:
            return .low
        case .sixth, .seventh, .eighth, .ninth, .tenth:
            return .medium
        case .eleventh, .twelfth, .thirteenth, .fourteenth, .fifteenth:
            return .high
        }
    }
    
    var isFireproof: Bool {
        switch self {
        case .fifth, .tenth, .fifteenth: return true
        default: return false
        }
    }
    
    var price: UInt {
        switch self {
        case .one: return 100
        case .second: return 200
        case .third: return 300
        case .fourth: return 500
        case .fifth: return 1000
        case .sixth: return 2000
        case .seventh: return 4000
        case .eighth: return 8000
        case .ninth: return 16000
        case .tenth: return 32000
        case .eleventh: return 64000
        case .twelfth: return 125_000
        case .thirteenth: return 250_000
        case .fourteenth: return 500_000
        case .fifteenth: return 1_000_000
        }
    }
}
