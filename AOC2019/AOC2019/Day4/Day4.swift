import Foundation
import AdventOfCode

public final class Day4: Day {
    private let from: Int
    private let to: Int
    
    public init(from: Int, to: Int) {
        self.from = from
        self.to = to
    }
    
    public override func part1() -> String {
        let number = (from...to).reduce(into: 0) { criteria, next in
            criteria += meetsCriteria(next, hasDoublePredicate: { $0 > 1 }) ? 1 : 0
        }
        return String(number)
    }
    
    public override func part2() -> String {
        let number = (from...to).reduce(into: 0) { criteria, next in
            criteria += meetsCriteria(next, hasDoublePredicate: { $0 == 2 }) ? 1 : 0
        }
        return String(number)
    }
    
    private func meetsCriteria(_ value: Int, hasDoublePredicate: (Int) -> Bool) -> Bool {
        let stringValue = String(value)
        let asInts = stringValue.exploded().compactMap(Int.init)

        let hasDouble = (stringValue.equalSubsequences().count(where: { hasDoublePredicate($0.count) }) > 0)
        let areIncreasing = zip(asInts, asInts.dropFirst()).allSatisfy({ $0 <= $1 })
        
        return hasDouble && areIncreasing
    }
}
