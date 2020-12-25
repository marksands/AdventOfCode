import Foundation
import AdventOfCode

public final class Day25: Day {
	private var input: String = ""

	public init(input: String = Input().trimmedRawInput()) {
		self.input = input
		super.init()
	}

	public override func part1() -> String {
		let cardKey = input.ints[0]
		let doorKey = input.ints[1]

		var value = 1

		var loopSize = 0
		while value != cardKey {
			loopSize += 1

			value = value * 7
			value = value % 20201227
		}

		value = 1
		for _ in (0..<loopSize) {
			value = value * doorKey
			value = value % 20201227
		}

		return String(value)
	}

	public override func part2() -> String {
		return ""
	}
}
