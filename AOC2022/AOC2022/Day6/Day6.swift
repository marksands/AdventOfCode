import Foundation
import AdventOfCode

public final class Day6: Day {
    private let input: String

    public init(rawInput: String = Input().trimmedRawInput()) {
        self.input = rawInput
        super.init()
    }

    public override func part1() -> String {
        return markerIndex(count: 4).string
    }

    public override func part2() -> String {
        return markerIndex(count: 14).string
    }

    private func markerIndex(count: Int) -> Int {
        let found = input.windows(ofCount: count).first(where: { Set($0).count == count })!
        return input.distance(from: input.startIndex, to: found.endIndex)
    }
}
