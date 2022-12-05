import Foundation
import AdventOfCode

public final class Day4: Day {
    private let lines: [String]

    public init(rawInput: [String] = Input().trimmedInputCharactersByNewlines()) {
        self.lines = rawInput
        super.init()
    }

    public override func part1() -> String {
        var count = 0
        for line in lines {
            let nums = line.ints
            let section1 = ClosedRange(uncheckedBounds: (nums[0], nums[1]))
            let section2 = ClosedRange(uncheckedBounds: (nums[2], nums[3]))
            if section1.isContainedWithin(section2) || section2.isContainedWithin(section1) {
                count += 1
            }
        }
        return count.string
    }

    public override func part2() -> String {
        var count = 0
        for line in lines {
            let nums = line.ints
            let section1 = ClosedRange(uncheckedBounds: (nums[0], nums[1]))
            let section2 = ClosedRange(uncheckedBounds: (nums[2], nums[3]))
            if section1.overlaps(section2) || section2.overlaps(section1) {
                count += 1
            }
        }
        return count.string
    }
}
