public class CircularList<T> {
    public let value: T
    
    var left: CircularList<T>!
    var right: CircularList<T>!
    
    public init(value: T) {
        self.value = value
        left = self
        right = self
    }
    
    @discardableResult
    public func insertAfter(_ value: T) -> CircularList<T> {
        let newNode = CircularList(value: value)
        newNode.right = right
        newNode.left = self

        right.left = newNode
        right = newNode
        
        return newNode
    }
    
    @discardableResult
    public func insertBefore(_ value: T) -> CircularList<T> {
        let newNode = CircularList(value: value)
        newNode.right = self
        newNode.left = left
        
        left.right = newNode
        left = newNode
        
        return newNode
    }
    
    @discardableResult
    public func remove() -> (left: CircularList<T>, right: CircularList<T>) {
        defer { left = nil; right = nil}

        left.right = right
        right.left = left
        
        return (left, right)
    }
    
    public func advance(by amount: Int) -> CircularList<T> {
        var node = self
        (0..<amount).forEach { _ in
            node = node.right
        }
        return node
    }
    
    public func reverse(by amount: Int) -> CircularList<T> {
        var node = self
        (0..<amount).forEach { _ in
            node = node.left
        }
        return node
    }
}
