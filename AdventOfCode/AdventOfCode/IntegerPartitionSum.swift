public struct IntegerPartitionSum: Sequence, IteratorProtocol {
    private var permutation: [Int]
    private var presentedFirstPermutation = false
    private var indexOfLastElement = 0
    
    public init(sum: Int) {
        permutation = [sum]
    }
    
    public mutating func next() -> [Int]? {
        guard presentedFirstPermutation else { presentedFirstPermutation = true; return permutation }
        
        var remVal = 0
        while indexOfLastElement >= 0 && permutation[indexOfLastElement] == 1 {
            remVal += permutation[indexOfLastElement]
            indexOfLastElement -= 1
        }
        
        if indexOfLastElement < 0 {
            return nil
        }
        
        permutation[indexOfLastElement] -= 1
        remVal += 1
        
        while remVal > permutation[indexOfLastElement] {
            permutation[indexOfLastElement+1] = permutation[indexOfLastElement]
            remVal = remVal - permutation[indexOfLastElement]
            indexOfLastElement += 1
        }
        
        if permutation.count <= indexOfLastElement + 1 {
            permutation.append(remVal)
        } else {
            permutation[indexOfLastElement+1] = remVal
        }
        indexOfLastElement += 1
        
        return Array(permutation[0...indexOfLastElement])
    }
}
