func binomial(n: Int, k: Int) -> Int {
    switch k {
    case n, 0: return 1
    case n...: return 0
    case (n / 2 + 1)...: return binomial(n: n, k: n - k)
    default: return n * binomial(n: n - 1, k: k - 1) / k
    }
}

public struct Combinations<Base: Collection>: Collection {
    var base: Base
    var k: Int
    
    init?(_ base: Base, k: Int) {
        self.base = base
        self.k = k
        if base.count < k {
            return nil
        }
    }
    
    public struct Index: Comparable {
        var indexes: [Base.Index]?
        func _nextState(in base: Base) -> [Base.Index]? {
            guard var indexes = indexes, !indexes.isEmpty
                else { return nil }
            let i = indexes.count - 1
            base.formIndex(after: &indexes[i])
            if indexes[i] != base.endIndex { return indexes }
            var j = i
            while indexes[i] == base.endIndex {
                j -= 1
                guard j >= 0
                    else { return nil }
                base.formIndex(after: &indexes[j])
                for k in indexes.indices[(j + 1)...] {
                    indexes[k] = base.index(after: indexes[k - 1])
                    if indexes[k] == base.endIndex {
                        break
                    }
                }
            }
            return indexes
        }
        
        public static func < (lhs: Index, rhs: Index) -> Bool {
            switch (lhs.indexes, rhs.indexes) {
            case (nil, _): return false   // (nil, some) or (nil, nil)
            case (_, nil): return true    // (some, nil)
            case (let l?, let r?):
                return l.lexicographicallyPrecedes(r)
            }
        }
    }
    
    public var count: Int {
        return binomial(n: base.count, k: k)
    }
    
    public var startIndex: Index {
        return Index(indexes: Array(base.indices.prefix(k)))
    }
    
    public var endIndex: Index {
        return Index(indexes: nil)
    }
    
    public func index(after i: Index) -> Index {
        return Index(indexes: i._nextState(in: base))
    }
    
    public subscript(i: Index) -> IndexingCollection<Base, [Base.Index]> {
        guard let indexes = i.indexes
            else { fatalError("Can't subscript with endIndex") }
        return IndexingCollection(base: base, indices: indexes)
    }
}

public struct IndexingCollection<Base: Collection, I: Collection> : Collection where I.Element == Base.Index {
    var base: Base
    var indices: I
    
    public typealias Index = I.Index
    
    public var startIndex: Index {
        return indices.startIndex
    }
    
    public var endIndex: Index {
        return indices.endIndex
    }
    
    public func index(after i: Index) -> Index {
        return indices.index(after: i)
    }
    
    public subscript(i: Index) -> Base.Element {
        return base[indices[i]]
    }
    
    public func distance(from start: I.Index, to end: I.Index) -> Int {
        return indices.distance(from: start, to: end)
    }
    
    public func index(_ i: I.Index, offsetBy n: Int) -> I.Index {
        return indices.index(i, offsetBy: n)
    }
}

extension IndexingCollection: BidirectionalCollection where I: BidirectionalCollection {
    public func index(before i: Index) -> Index {
        return indices.index(before: i)
    }
}

extension IndexingCollection: RandomAccessCollection where I: RandomAccessCollection {}

extension Collection {
    public func combinations(of k: Int) -> Combinations<Self> {
        return Combinations(self, k: k)!
    }

    public func combinations(of range: ClosedRange<Int>) -> FlattenCollection<[Combinations<Self>]> {
        return range.map(self.combinations(of:)).joined()
    }

    public func indexed<C: Collection>(by indexes: C) -> IndexingCollection<Self, C> where C.Element == Index {
        return IndexingCollection(base: self, indices: indexes)
    }
}
