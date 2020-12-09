import Foundation
import AdventOfCode

public final class Day9: Day {
	private var numbers: [Int] = []

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		super.init()
		self.numbers = input.compactMap { Int($0) }
	}

	public override func part1() -> String {
		for index in numbers.indices {
			if index >= 25 {
				let previous25 = numbers[index.advanced(by: -25)...index].combinations(of: 2)
				if !previous25.contains(where: { $0.sum() == numbers[index] }) {
					return String(numbers[index])
				}
			}
		}

		return "-1"
	}

	public override func part2() -> String {
		let target = 138879426

		var start = 0
		var end = 1
		var result = 0

		for _ in numbers.indices {
			let sum = numbers[start...end].sum()
			
			if sum == target {
				result = numbers[start...end].min()! + numbers[start...end].max()!
				return String(result)
			} else if sum < target {
				end += 1
			} else if sum > target {
				start += 1
	 		}
		}

		return "-1"
	}
}

