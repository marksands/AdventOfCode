import Foundation
import AdventOfCode

public final class Day5: Day {
	let lines: [String]
	let positions: [(start: Position, end: Position)]
	
	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.lines = lines
		
		var positions: [(start: Position, end: Position)] = []
		for line in lines {
			let start = line.ints[0...1]
			let end = line.ints[2...3]
			let startPosition = Position(x: start[0], y: start[1])
			let endPosition = Position(x: end[2], y: end[3])
			let vector = (start: startPosition, end: endPosition)
			positions.append(vector)
		}
		
		self.positions = positions
		super.init()
	}

    public override func part1() -> String {
		var dictionaryOfPositionsToLineCount: [Position: Int] = [:]
		findAndIncrementStraightLineIntersections(&dictionaryOfPositionsToLineCount)
		return dictionaryOfPositionsToLineCount.values.count(where: { $0 > 1 }).string
    }

    public override func part2() -> String {
		var dictionaryOfPositionsToLineCount: [Position: Int] = [:]
		findAndIncrementStraightLineIntersections(&dictionaryOfPositionsToLineCount)

		let diagonalPositions = self.positions.filter { !($0.start.x == $0.end.x || $0.start.y == $0.end.y) }
		
		for diagonalLine in diagonalPositions {
			if diagonalLine.start.x < diagonalLine.end.x {
				if diagonalLine.start.y < diagonalLine.end.y {
					var x = diagonalLine.start.x
					var y = diagonalLine.start.y
					while x <= diagonalLine.end.x && y <= diagonalLine.end.y {
						dictionaryOfPositionsToLineCount[Position(x: x, y: y), default: 0] += 1
						x += 1
						y += 1
					}
				} else {
					var x = diagonalLine.start.x
					var y = diagonalLine.start.y
					while x <= diagonalLine.end.x && y >= diagonalLine.end.y {
						dictionaryOfPositionsToLineCount[Position(x: x, y: y), default: 0] += 1
						x += 1
						y -= 1
					}
				}
			} else {
				if diagonalLine.start.y < diagonalLine.end.y {
					var x = diagonalLine.start.x
					var y = diagonalLine.start.y
					while x >= diagonalLine.end.x && y <= diagonalLine.end.y {
						dictionaryOfPositionsToLineCount[Position(x: x, y: y), default: 0] += 1
						x -= 1
						y += 1
					}
				} else {
					var x = diagonalLine.start.x
					var y = diagonalLine.start.y
					while x >= diagonalLine.end.x && y >= diagonalLine.end.y {
						dictionaryOfPositionsToLineCount[Position(x: x, y: y), default: 0] += 1
						x -= 1
						y -= 1
					}
				}
			}
		}

		return dictionaryOfPositionsToLineCount.values.count(where: { $0 > 1 }).string
    }
	
	private func findAndIncrementStraightLineIntersections(_ dictionary: inout [Position: Int]) {
		let straightPositions = positions.filter { $0.start.x == $0.end.x || $0.start.y == $0.end.y }
		
		for straightLine in straightPositions {
			let minY = min(straightLine.start.y, straightLine.end.y)
			let maxY = max(straightLine.start.y, straightLine.end.y)
			let minX = min(straightLine.start.x, straightLine.end.x)
			let maxX = max(straightLine.start.x, straightLine.end.x)
			
			(Int(minY)...Int(maxY)).forEach { y in
				(Int(minX)...Int(maxX)).forEach { x in
					dictionary[Position(x: x, y: y), default: 0] += 1
				}
			}
		}
	}
}
