import Foundation
import AdventOfCode

public final class Day15: Day {
	var gridOfInts: [[Int]] = []
	var grid: [Position: Int] = [:]

	var height: Int
	var width: Int
	var bottomCorner: Position
	var startingCost: Int
	var scores: [Position: Int] = [:]

	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		for (y, line) in lines.enumerated() {
			var row: [Int] = []
			for (x, col) in line.exploded().enumerated() {
				row.append(Int(col)!)
				grid[Position(x: x, y: y)] = Int(col)!
			}
			gridOfInts.append(row)
		}
		
		height = gridOfInts.count - 1
		width = gridOfInts[0].count - 1
		bottomCorner = Position(x: width, y: height)
		startingCost = grid[Position(x: 0, y: 0)]!
		scores[Position(x: 0, y: 0)] = 0
	}

    public override func part1() -> String {
		var priorityQueue = PriorityQueue<Position>(sort: {
			self.scores[$0, default: Int.max] < self.scores[$1, default: Int.max]
		})

		priorityQueue.enqueue(Position(x: 0, y: 0))

		while let top = priorityQueue.dequeue() {
			if top == bottomCorner {
				printScores()
				return scores[bottomCorner]!.string
			}
			else {
				for potentialPath in pathNeighbors(of: top) {
					priorityQueue.enqueue(potentialPath)
				}
			}
		}

        return ":("
    }

    public override func part2() -> String {
		return ":("
    }

	@inline(__always)
	private func pathNeighbors(of path: Position) -> [Position] {
		var neighbors: [Position] = []
		
		func isWithinRange(_ pos: Position) -> Bool {
			return pos.x >= 0 && pos.x <= width && pos.y >= 0 && pos.y <= height
		}

		let currentScore = scores[path]!

		for cell in path.adjacent() where isWithinRange(cell) {
			let score = currentScore + grid[cell]!
			if score < scores[cell, default: Int.max] {
				scores[cell] = min(scores[cell, default: Int.max], score)
				neighbors.append(cell)
			}
		}

		return neighbors
	}
	
	func printScores() {
		var string = "SCORES: \n"
		for (y, row) in gridOfInts.enumerated() {
			for (x, col) in row.enumerated() {
				if let s = scores[Position(x: x, y: y)] {
					let pad = 3 - String(s).count
					let padStr = String(repeating: "0", count: pad)
					string += "[\(padStr + String(s))]"
				} else {
					string += "[?\(col)?]"
				}
			}
			string += "\n"
		}
		print(string)
	}
}
