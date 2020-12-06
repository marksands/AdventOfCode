import Foundation
import AdventOfCode

public final class Day6: Day {
	private var input: [String] = []

	public init(input: String = Input().trimmedRawInput()) {
		super.init()
		self.input = input.components(separatedBy: "\n\n")
	}

	public override func part1() -> String {
		return String(input.reduce(into: 0) { $0 += Set($1.stripping("\n")).count })
	}

	public override func part2() -> String {
		return String(input.reduce(0) { a, b in
			a + b.components(separatedBy: "\n")
				.reduce(Set(b)) { $0.intersection($1) }
				.count
		})
	}
}
