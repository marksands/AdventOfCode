import Foundation
import AdventOfCode

public final class Day9: Day {
	private var numbers: [Int] = []

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		super.init()
		self.numbers = input.compactMap { Int($0) }
	}

	public override func part1() -> String {
		let index = numbers.indices.first { index in
			index >= 25 && !numbers[index.advanced(by: -25)...index]
				.combinations(of: 2)
				.contains(where: { $0.sum() == numbers[index] })
		}!
		return String(numbers[index])
	}

	public override func part2() -> String {
		func extremesOfTargetSums(_ start: Int, _ end: Int, _ sum: Int, _ target: Int) -> Int {
			switch sum {
			case target: return numbers[start...end].min()! + numbers[start...end].max()!
			case 0..<target: return extremesOfTargetSums(start, end + 1, sum + numbers[end+1], target)
			default: return extremesOfTargetSums(start + 1, end, sum - numbers[start], target)
			}
		}

		return String(extremesOfTargetSums(0, 0, numbers[0], 138879426))
	}
}
