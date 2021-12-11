import Foundation
import AdventOfCode

public final class Day11: Day {
	let lines: [String]
	
	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.lines = lines
	}
	
    public override func part1() -> String {
		var grid: [Position: Int] = [:]

		for (y, line) in lines.enumerated() {
			for (x, value) in line.exploded().enumerated() {
				let num = Int(value)!
				grid[Position(x: x, y: y)] = num
			}
		}
		
		func isWithinGrid(_ position: Position) -> Bool {
			let width = lines[0].count
			let height = lines.count
			return position.x >= 0 && position.x < width &&
			position.y >= 0 && position.y < height
		}
		
		var flashCount = 0
		
		for step in (0..<100) {
			var copy = grid
			var flashed: Set<Position> = []
			var q: [Position] = []
			
			// all cells increment by 1
			for (key, _) in copy {
				copy[key, default: 0] += 1
				if copy[key, default: 0] > 9 {
					q.append(key)
					flashed.insert(key)
				}
			}

			// flash effects surrounding cells
			while let front = q.popFirst() {
				for neighbor in front.surrounding() {
					if !isWithinGrid(neighbor) { continue }
					copy[neighbor, default: 0] += 1
					if copy[neighbor, default: 0] > 9 {
						if !flashed.contains(neighbor) {
							q.append(neighbor)
						}
						flashed.insert(neighbor)
					}
				}
			}

			// reset flashed positions to 0
			flashed.forEach { position in
				copy[position] = 0
			}

			flashCount += flashed.count
			
			grid = copy
		}

		return flashCount.string
    }

    public override func part2() -> String {
		var grid: [Position: Int] = [:]

		for (y, line) in lines.enumerated() {
			for (x, value) in line.exploded().enumerated() {
				let num = Int(value)!
				grid[Position(x: x, y: y)] = num
			}
		}
		
		func isWithinGrid(_ position: Position) -> Bool {
			let width = lines[0].count
			let height = lines.count
			return position.x >= 0 && position.x < width &&
			position.y >= 0 && position.y < height
		}
		
		var flashCount = 0
		let stopCount = grid.keys.count
		
		var step = 0
		while flashCount != stopCount {
			var copy = grid
			var flashed: Set<Position> = []
			var q: [Position] = []
			
			// all cells increment by 1
			for (key, _) in copy {
				copy[key, default: 0] += 1
				if copy[key, default: 0] > 9 {
					q.append(key)
					flashed.insert(key)
				}
			}

			// flash effects surrounding cells
			while let front = q.popFirst() {
				for neighbor in front.surrounding() {
					if !isWithinGrid(neighbor) { continue }
					copy[neighbor, default: 0] += 1
					if copy[neighbor, default: 0] > 9 {
						if !flashed.contains(neighbor) {
							q.append(neighbor)
						}
						flashed.insert(neighbor)
					}
				}
			}

			// reset flashed positions to 0
			flashed.forEach { position in
				copy[position] = 0
			}

			flashCount = flashed.count
			step += 1
			
			grid = copy
		}

		return step.string
    }
	
	private func printGrid(_ step: Int, _ grid: [Position: Int]) {
		print("")
		print(">> Step \(step):")
		for (y, line) in lines.enumerated() {
			var result = ""
			for (x, _) in line.exploded().enumerated() {
				result += String(grid[Position(x: x, y: y)]!)
			}
			print(result)
		}
	}
}
