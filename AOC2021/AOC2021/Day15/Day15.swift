import Foundation
import AdventOfCode

public final class Day15: Day {
	var lines: [String]

	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.lines = lines
	}

    public override func part1() -> String {
		return traverse(part1: true)
	}

    public override func part2() -> String {
		return traverse(part1: false)
	}
		
	private func traverse(part1: Bool) -> String {
		// MARK: - Setup
		
		let multiplier = [
			[1, 2, 3, 4, 5],
			[2, 3, 4, 5, 6],
			[3, 4, 5, 6, 7],
			[4, 5, 6, 7, 8],
			[5, 6, 7, 8, 9]
		]
		
		var modifiedLines: [String] = []
		
		for row in multiplier {
			for line in lines {
				var newLine = ""
				zip(row, [line, line, line, line, line]).forEach { m, line in
					newLine += line.exploded().map { ((Int($0)! + m - 2) % 9) + 1 }.map { String($0) }.joined()
				}
				modifiedLines.append(newLine)
			}
		}
		
		var gridOfInts: [[Int]] = []
		var grid: [Position: Int] = [:]

		if !part1 {
			self.lines = modifiedLines
		}
		
		for (y, line) in lines.enumerated() {
			var row: [Int] = []
			for (x, col) in line.exploded().enumerated() {
				row.append(Int(col)!)
				grid[Position(x: x, y: y)] = Int(col)!
			}
			gridOfInts.append(row)
		}
		
		let height = gridOfInts.count - 1
		let width = gridOfInts[0].count - 1
		let bottomCorner = Position(x: width, y: height)
		var scores = [Position(x: 0, y: 0): 0]
		
		// MARK: - Traversal
		
		@inline(__always)
		func neighbors(of position: Position) -> [Position] {
			var neighbors: [Position] = []

			for cell in position.adjacent() where cell.x >= 0 && cell.x <= width && cell.y >= 0 && cell.y <= height {
				let score = scores[position]! + grid[cell]!
				if score < scores[cell, default: Int.max] {
					scores[cell] = min(scores[cell, default: Int.max], score)
					neighbors.append(cell)
				}
			}

			return neighbors
		}
		
		var priorityQueue = PriorityQueue<Position>(sort: {
			scores[$0, default: Int.max] < scores[$1, default: Int.max]
		})
		
		priorityQueue.enqueue(Position(x: 0, y: 0))
		
		while let front = priorityQueue.dequeue() {
			if front == bottomCorner {
				return scores[bottomCorner]!.string
			}
			else {
				for potentialPath in neighbors(of: front) {
					priorityQueue.enqueue(potentialPath)
				}
			}
		}
		
		fatalError()
	}
}
