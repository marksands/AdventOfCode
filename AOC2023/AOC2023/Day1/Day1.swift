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

        let table = [
            "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
            "one":1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9,
            "eno": 1, "owt": 2, "eerht": 3, "ruof": 4, "evif": 5, "xis": 6, "neves": 7, "thgie": 8, "enin": 9
        ]

        var elements: [Int] = []
        for line in input.lines {
            if let _first = firstR.allMatches(line).first?.matches.first,
               let _last = lastR.allMatches(line.reversed).first?.matches.first,
               let first = table[_first], let last = table[_last] {
                elements.append((String(first) + String(last)).int)
            }
        }
        return elements.sum().string
    }
}
