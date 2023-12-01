import Foundation
import AdventOfCode

public final class Day1: Day {
    private let input: String

    public init(rawInput: String = Input().trimmedRawInput()) {
        self.input = rawInput
        super.init()
    }

    public override func part1() -> String {
        return input.lines.reduce(into: [Int](), { elements, line in
            if let first = line.singleDigitInts.first, let last = line.singleDigitInts.last {
                elements.append((String(first) + String(last)).int)
            }
        }).sum().string
    }

    public override func part2() -> String {
        let firstR = Regex(pattern: "(1|2|3|4|5|6|7|8|9|one|two|three|four|five|six|seven|eight|nine)")
        let lastR = Regex(pattern: "(1|2|3|4|5|6|7|8|9|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin)")

        let f = NumberFormatter()
        f.numberStyle = .spellOut

        return input.lines.reduce(into: [Int](), { elements, line in
            if let _first = firstR.allMatches(line).first?.matches.first,
               let _last = lastR.allMatches(line.reversed).first?.matches.first,
               let first = Int(_first) ?? f.number(from: _first)?.intValue, let last = Int(_last) ?? f.number(from: _last.reversed)?.intValue {
                elements.append((String(first) + String(last)).int)
            }
        }).sum().string
    }
}
