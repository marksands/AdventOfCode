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
        let number = (from...to).count(where: { value in
            meetsCriteria(value, hasDoublePredicate: { $0 > 1 })
        })
        return String(number)
    }
    
    public override func part2() -> String {
        let number = (from...to).count(where: { value in
            meetsCriteria(value, hasDoublePredicate: { $0 == 2 })
        })
        return String(number)
    }
    
    private func meetsCriteria(_ value: Int, hasDoublePredicate: (Int) -> Bool) -> Bool {
        let stringValue = String(value)
        let asInts = stringValue.exploded().compactMap(Int.init)

        let hasDouble = (stringValue.equalSubsequences().count(where: { hasDoublePredicate($0.count) }) > 0)
        let areIncreasing = asInts.eachPair().allSatisfy({ $0 <= $1 })
        
        return hasDouble && areIncreasing
    }
}
