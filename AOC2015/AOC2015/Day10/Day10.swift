import Foundation
import AdventOfCode

public final class Day10: Day {
    private let input = "1321131112"
    
    public override func part1() -> String {
        return String(lookAndSayCount(times: 40))
    }
    
    public override func part2() -> String {
        return String(lookAndSayCount(times: 50))
    }
    
    private func lookAndSayCount(times: Int) -> Int {
        var result = input
        (0..<times).forEach { _ in
            let seenValues = result.exploded().reduce(into: [[String]]()) { seed, result in
                if seed.last?.last == result {
                    let last = seed.last! + [result]
                    seed.removeLast()
                    seed.append(last)
                } else {
                    seed.append([result])
                }
            }
            result = seenValues.reduce(into: "") { result, next in
                result += "\(next.count)\(next[0])"
            }
        }
        return result.count
    }
}
