import Foundation
import AdventOfCode

public final class Day10: Day {
    private let input = Input().trimmedRawInput()
    
    public override func part1() -> String {
        return String(lookAndSayLength(times: 40))
    }
    
    public override func part2() -> String {
        return String(lookAndSayLength(times: 50))
    }
    
    private func lookAndSayLength(times: Int) -> Int {
        var result = input
        (0..<times).forEach { _ in
            result = result.equalSubsequences().reduce(into: "") {
                $0 += "\($1.count)\($1.first!)"
            }
        }
        return result.count
    }
}
