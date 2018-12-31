import Foundation
import AdventOfCode

public final class Day8: Day {
    private let input = Input().trimmedInputCharactersByNewlines()

    public override func part1() -> String {
        let escape = Regex(pattern: "(\\\\{2})")
        let quote = Regex(pattern: "(\\\")")
        let hex = Regex(pattern: "(\\\\x[a-f0-9]{2})")
        
        let sum = input.reduce(into: 0) { result, line in
            let escapeSequenceCounts = escape.allMatches(line).count + quote.allMatches(line).count + hex.allMatches(line).count
            let totalEscapeSequenceCount = (escape.allMatches(line).count * 2) + (quote.allMatches(line).count * 2) + (hex.allMatches(line).count * 4)
            result += line.count - (line.count-totalEscapeSequenceCount+escapeSequenceCounts)
        }
        return "\(sum)"
    }
    
    public override func part2() -> String {
        let sum = input.reduce(into: 0) { result, line in
            let encodedCount = (line.reduce(into: "\"") { result, character in
                result += (character == "\"" || character == "\\") ? "\\" : ""
                result += String(character)
            } + "\"").count
            result += (encodedCount - line.count)
        }
        return "\(sum)"
    }
}
