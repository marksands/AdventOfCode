import Foundation
import AdventOfCode

public final class Day3: Day {
	private let terrain: [String]

	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.terrain = lines

		super.init()
	}

	public override func part1() -> String {
		return String(trees(right: 3, down: 1))
	}

	public override func part2() -> String {
		let hits = [1, 3, 5, 7].product { trees(right: $0, down: 1) } * trees(right: 1, down: 2)
		return String(hits)
	}

	func trees(right: Int, down: Int) -> Int {
		var trees = 0
		let rowWidth = terrain[0].count

		var dx = 0
		var dy = 0

		while dy < terrain.count {
			if terrain[dy % terrain.count][unsafe: dx % rowWidth] == "#" {
				trees += 1
			}
			dx += right
			dy += down
		}

		return trees
	}
}
