// Created by deovinsum

import Foundation

struct UserPoints: Identifiable, Codable, Hashable {
    var id = UUID()
    
    let user: String
    let points: UInt16
}
