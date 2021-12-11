import Foundation
import AdventOfCode

public final class Day11: Day {
	let lines: [String]
	var grid: [Position: Int] = [:]

	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.lines = lines
		
		for (y, line) in lines.enumerated() {
			for (x, value) in line.exploded().enumerated() {
				let num = Int(value)!
				grid[Position(x: x, y: y)] = num
			}
		}
	}
	
    public override func part1() -> String {
		return run().part1
	}

    public override func part2() -> String {
		return run().part2
	}
	
	private func run() -> (part1: String, part2: String) {
		var part1FlashCount = 0
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

			// flash surrounding cells
			while let front = q.popFirst() {
				for neighbor in front.surrounding(withinGrid: grid) {
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
			
			grid = copy

			flashCount = flashed.count
			step += 1
			if step <= 100 {
				part1FlashCount += flashed.count
			}
		}

		return (part1FlashCount.string, step.string)
	}
}
