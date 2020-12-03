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
		var hits: [Int] = []

		hits.append(trees(right: 1, down: 1))
		hits.append(trees(right: 3, down: 1))
		hits.append(trees(right: 5, down: 1))
		hits.append(trees(right: 7, down: 1))
		hits.append(trees(right: 1, down: 2))

		return String(hits.product())
	}

	func trees(right: Int, down: Int) -> Int {
		var trees = 0
		let rowWidth = terrain[0].exploded().count

		var x = 0
		var y = 0

		while y < terrain.count {
			let character = terrain[y % terrain.count].exploded()[x % rowWidth]
			if character == "#" {
				trees += 1
			}
			x += right
			y += down
		}

		return trees
	}
}
