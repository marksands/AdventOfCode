import Foundation
import AdventOfCode

public final class Day9: Day {
	var positions: [Position: Int] = [:]
	var numericLines: [[Int]] = []

	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		for row in lines {
			numericLines.append(row.exploded().map { Int($0)! })
		}
		
		for (y, row) in numericLines.enumerated() {
			for (x, col) in row.enumerated() {
				positions[Position(x: x, y: y)] = col
			}
		}
	}

    public override func part1() -> String {
		var riskFactors: [Int] = []

		for (y, row) in numericLines.enumerated() {
			for (x, col) in row.enumerated() {
				let cur = Position(x: x, y: y)
				if cur.adjacent().allSatisfy({ positions[$0, default: 9] > positions[cur]! }) {
					riskFactors.append(col + 1)
				}
			}
		}

		return riskFactors.sum().string
    }

    public override func part2() -> String {
		var basinSizes: [Int] = []
		var seen: Set<Position> = []
				
		for (y, row) in numericLines.enumerated() {
			for (x, col) in row.enumerated() {
				let cur = Position(x: x, y: y)
				if seen.contains(cur) { continue }
				if col == 9 {
					seen.insert(cur)
					continue
				}
				
				var basinCount = 0
				var stack: [Position] = []
				stack.append(cur)

				while !stack.isEmpty {
					let top = stack.removeLast()
					if seen.contains(top) { continue }
					seen.insert(top)
					if let value = positions[top] {
						if value < 9 {
							basinCount += 1
							for adjacent in top.adjacent() where !seen.contains(adjacent) {
								stack.append(adjacent)
							}
						}
					}
				}
				
				basinSizes.append(basinCount)
			}
		}

		return basinSizes.sorted().reversed()[0..<3].product().string
    }
}
