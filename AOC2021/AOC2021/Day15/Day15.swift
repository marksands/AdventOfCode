import Foundation
import AdventOfCode

public final class Day15: Day {
	var lines: [String]
	
	var gridOfInts: [[Int]] = []
	var grid: [Position: Int] = [:]

	var height: Int = 0
	var width: Int = 0
	var bottomCorner: Position = .zero
	var startingCost: Int = 0
	var scores: [Position: Int] = [:]

	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.lines = lines
	}

    public override func part1() -> String {
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

		var priorityQueue = PriorityQueue<Position>(sort: {
			self.scores[$0, default: Int.max] < self.scores[$1, default: Int.max]
		})

		priorityQueue.enqueue(Position(x: 0, y: 0))

		while let top = priorityQueue.dequeue() {
			if top == bottomCorner {
				return scores[bottomCorner]!.string
			}
			else {
				for potentialPath in pathNeighbors(of: top) {
					priorityQueue.enqueue(potentialPath)
				}
			}
		}

		fatalError()
    }

    public override func part2() -> String {
		let multiplier = [
			[1, 2, 3, 4, 5],
			[2, 3, 4, 5, 6],
			[3, 4, 5, 6, 7],
			[4, 5, 6, 7, 8],
			[5, 6, 7, 8, 9]
		]
		
		func addAndWrap(_ left: Int, _ right: Int) -> Int {
			let result = left + right
			if result > 9 { return result - 9 }
			return result
		}
		
		var modifiedLines: [String] = []
		
		for (_, row) in multiplier.enumerated() {
			for line in lines {
				var newLine = ""
				zip(row, [line, line, line, line, line]).forEach { m, line in
					newLine += line.exploded().map { addAndWrap(Int($0)!, m-1) }.map { String($0) }.joined()
				}
				modifiedLines.append(newLine)
			}
		}
		
		for (y, line) in modifiedLines.enumerated() {
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

		var priorityQueue = PriorityQueue<Position>(sort: {
			self.scores[$0, default: Int.max] < self.scores[$1, default: Int.max]
		})

		priorityQueue.enqueue(Position(x: 0, y: 0))

		while let top = priorityQueue.dequeue() {
			if top == bottomCorner {
				return scores[bottomCorner]!.string
			}
			else {
				for potentialPath in pathNeighbors(of: top) {
					priorityQueue.enqueue(potentialPath)
				}
			}
		}

		fatalError()
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
}
