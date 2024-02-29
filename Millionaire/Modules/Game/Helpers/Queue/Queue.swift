import Foundation

struct Queue<T> {
    private var dequeueStack = [T]()
    private var enqueueStack = [T]()
}

extension Queue: QueueProtocol {
    var isEmpty: Bool {
        dequeueStack.isEmpty && enqueueStack.isEmpty
    }
    
    var peek: T? {
        !dequeueStack.isEmpty ? dequeueStack.last : enqueueStack.first
    }
    
    var count: Int {
        dequeueStack.count + enqueueStack.count
    }
    
    mutating func enqueue(_ element: T) {
        enqueueStack.append(element)
    }
    
    @discardableResult
    mutating func dequeue() -> T? {
        if dequeueStack.isEmpty {
            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        return dequeueStack.popLast()
    }
}
