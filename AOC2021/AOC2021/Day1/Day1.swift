import Foundation
import AdventOfCode

public final class Day1: Day {
	private let numbers: [Int]

	public init(numbers: [Int] = Input().inputCharactersByNewlines().compactMap(Int.init)) {
		self.numbers = numbers
		super.init()
	}

	public override func part1() -> String {
        return String(
            numbers
                .eachPair()
                .count(where: { $1 > $0 })
        )
	}

	public override func part2() -> String {
        return String(
            numbers
                .windows(ofCount: 3)
                .map { $0.sum() }
                .eachPair()
                .count(where: { $1 > $0 })
        )
	}
}
