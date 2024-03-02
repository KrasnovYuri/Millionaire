import Foundation

protocol QueueProtocol {
    associatedtype Element
    
    var isEmpty: Bool { get }
    var peek: Element? { get }
    var count: Int { get }
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
}
