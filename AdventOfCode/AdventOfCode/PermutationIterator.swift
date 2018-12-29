public struct Permutations<T>: Sequence, IteratorProtocol {
    private var base: [T]
    private var permutation: [Int]
    private var presentedFirstPermutation = false
    
    public init<S: Sequence>(_ sequence: S) where S.Element == T {
        base = Array(sequence)
        permutation = Array(repeating: 0, count: base.count)
    }
    
    public mutating func next() -> [T]? {
        guard presentedFirstPermutation else { presentedFirstPermutation = true; return base }
        
        var index = 0
        while index < base.count {
            if permutation[index] < index {
                if index % 2 == 0 {
                    base.swapAt(0, index)
                } else {
                    base.swapAt(permutation[index], index)
                }
                permutation[index] += 1
                index = 0
                return base
            } else {
                permutation[index] = 0
                index += 1
            }
        }
        return nil
    }
}

extension Sequence {//} where Element: Comparable {
    public func permutations() -> Permutations<Element> {
        return Permutations(self)
    }
}
