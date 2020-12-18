import Foundation
import AdventOfCode

public final class Day17: Day {
	private var initialGrid: [Position: Bool] = [:]

	public init(input: String = Input().trimmedRawInput()) {
		super.init()

		for (y, line) in input.lines.enumerated() {
			for (x, c) in line.enumerated() {
				if c == "#" {
					initialGrid[Position(x: x, y: y, z: 0, w: 0)] = true
				}
			}
		}
	}

	public override func part1() -> String {
		var grid = initialGrid

		for _ in (0..<6) {
			var mark: [Position: Int] = [:]

			for (key, _) in grid {
				for z in (-1...1) {
					for y in (-1...1) {
						for x in (-1...1) {
							if z == y, y == x, x == 0 {
								continue
							}
							mark[Position(x: key.x + x, y: key.y + y, z: key.z + z), default: 0] += 1
						}
					}
				}
			}

			var sweep: [Position: Bool] = [:]

			for (key, value) in mark {
				if !grid[key, default: false], value == 3 {
					sweep[key] = true
				} else if grid[key, default: false] && (value == 2 || value == 3) {
					sweep[key] = true
				}
			}

			grid = sweep
		}

		return String(grid.values.count(where: { $0 }))
	}

	public override func part2() -> String {
		var grid = initialGrid

		for _ in (0..<6) {
			var mark: [Position: Int] = [:]

			for (key, _) in grid {
				for w in (-1...1) {
					for z in (-1...1) {
						for y in (-1...1) {
							for x in (-1...1) {
								if w == z, z == y, y == x, x == 0 {
									continue
								}
								mark[Position(x: key.x + x, y: key.y + y, z: key.z + z, w: key.w + w), default: 0] += 1
							}
						}
					}
				}
			}

			var sweep: [Position: Bool] = [:]

			for (key, value) in mark {
				if !grid[key, default: false], value == 3 {
					sweep[key] = true
				} else if grid[key, default: false] && (value == 2 || value == 3) {
					sweep[key] = true
				}
			}

			grid = sweep
		}

		return String(grid.values.count(where: { $0 }))
	}
}
