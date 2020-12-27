public struct Heap<T> {
    private var nodes: [T] = []
    private let sortOrder: (T, T) -> Bool
    
    public var count: Int {
        return nodes.count
    }
    
    public init(sort: @escaping (T, T) -> Bool) {
        sortOrder = sort
    }
    
    public mutating func insert(_ value: T) {
        nodes.append(value)
        shiftUp()
    }
    
    public mutating func remove() -> T? {
        guard !nodes.isEmpty else { return nil }
        
        if nodes.count == 1 {
            return nodes.removeLast()
        } else {
            let root = nodes.first
            nodes[0] = nodes.removeLast()
            shiftDown()
            return root
        }
    }

	@_transparent
    private func leftIndex(of child: Int) -> Int {
        return 2*child + 1
    }
    
	@_transparent
	private func rightIndex(of child: Int) -> Int {
        return 2*child + 2
    }

	@_transparent
    private func parentIndex(of child: Int) -> Int {
        return Int((child - 1)/2)
    }
    
    private mutating func shiftUp() {
        var childIndex = nodes.count - 1
        let temp = nodes[childIndex]
        
        while (childIndex > 0 && sortOrder(temp, nodes[parentIndex(of: childIndex)])) {
            nodes[childIndex] = nodes[parentIndex(of: childIndex)]
            childIndex = parentIndex(of: childIndex)
        }
        
        nodes[childIndex] = temp
    }
    
    private mutating func shiftDown() {
        var index = 0
        
        while leftIndex(of: index) < count {
            var child = index
            
            if leftIndex(of: index) < count && sortOrder(nodes[leftIndex(of: index)], nodes[child]) {
                child = leftIndex(of: index)
            }
            
            if rightIndex(of: index) < count && sortOrder(nodes[rightIndex(of: index)], nodes[child]) {
                child = rightIndex(of: index)
            }
            
            if child == index {
                break
            }
            
            nodes.swapAt(index, child)
            index = child
        }
    }
}
