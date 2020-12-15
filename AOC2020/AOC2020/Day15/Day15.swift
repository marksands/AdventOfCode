import Foundation
import AdventOfCode

public final class Day15: Day {
	public override func part1() -> String {
		return String(compute(maxTurns: 2020))
	}

	public override func part2() -> String {
		return String(compute(maxTurns: 30000000))
	}

	private func compute(maxTurns: Int) -> Int {
		let input = "2,15,0,9,1,20"
		let starterNumbers = input.split(separator: ",").map { Int($0)! }

		var turnIndex: [Int: (Int, Int)] = [:]

		var currentNumber = 0

		var turn = 0
		while turn < maxTurns {
			let isNew = turnIndex[currentNumber] == nil
			turnIndex[currentNumber] = (turnIndex[currentNumber, default: (0, 0)].1, turn)

			if turn < starterNumbers.count {
				currentNumber = starterNumbers[turn]
			} else if isNew {
				currentNumber = 0
			} else {
				currentNumber = turnIndex[currentNumber]!.1 - turnIndex[currentNumber]!.0
			}

			turn += 1
		}

		return currentNumber
	}
}
