import Foundation
import AdventOfCode

public final class Day1: Day {
    private let input = Input().trimmedRawInput().exploded()
    
    public override func part1() -> String {
        let count = input.reduce(into: 0) { result, paren in
            result += (paren == "(" ? 1 : -1)
        }
        return "\(count)"
    }
    
    public override func part2() -> String {
        var count = 0
        var result = 0
        while result != -1 {
            count += 1
            result += (input[count-1] == "(" ? 1 : -1)
        }
        return "\(count)"
    }
}
