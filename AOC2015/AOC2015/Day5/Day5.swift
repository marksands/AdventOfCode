import Foundation
import AdventOfCode

public final class Day5: Day {
    private let input = Input().trimmedInputCharactersByNewlines()
    
    public override func part1() -> String {
        return String(input.reduce(into: 0, { $0 += (isNicePart1($1) ? 1 : 0) }))
    }
    
    public override func part2() -> String {
        return String(input.reduce(into: 0, { $0 += (isNicePart2($1) ? 1 : 0) }))
    }
    
    private func isNicePart1(_ value: String) -> Bool {
        return Regex(pattern: "^.*[aeiou].*[aeiou].*[aeiou].*$") ~= value && Regex(pattern: "^.*([a-z])\\1.*$") ~= value && !(Regex(pattern: "^.*(ab|cd|pq|xy).*$") ~= value)
    }

    private func isNicePart2(_ value: String) -> Bool {
        return Regex(pattern: "^.*([a-z])[a-z]\\1.*$") ~= value && Regex(pattern: "^.*([a-z][a-z]).*\\1.*$") ~= value
    }
}
