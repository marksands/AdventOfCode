import Foundation
import AdventOfCode

public final class Day1: Day {
    private let input: String

    public init(rawInput: String = Input().trimmedRawInput()) {
        self.input = rawInput
        super.init()
    }

    public override func part1() -> String {
        return input.groups
            .map { $0.ints.sum() }
            .max()!
            .string
    }

    public override func part2() -> String {
        let sums = input.groups
            .map { $0.ints.sum() }
            .sorted(by: >)
        return sums[0..<3].sum().string
    }
}
