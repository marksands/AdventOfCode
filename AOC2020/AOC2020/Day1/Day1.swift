import Foundation
import AdventOfCode

public final class Day1: Day {
	private let numbers: [Int]

	public init(numbers: [Int] = Input().inputCharactersByNewlines().compactMap(Int.init)) {
		self.numbers = numbers
		super.init()
	}

	public override func part1() -> String {
		guard let slice = numbers.combinations(of: 2).first(where: { $0.sum() == 2020 }) else {
			return ""
		}
		return "\(slice.multiply())"
	}

	public override func part2() -> String {
		guard let slice = numbers.combinations(of: 3).first(where: { $0.sum() == 2020 }) else {
			return ""
		}
		return "\(slice.multiply())"
	}
}
