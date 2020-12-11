import Foundation
import AdventOfCode

public final class Day11: Day {
	private var input: [String] = []

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		super.init()
		self.input = input
	}

	public override func part1() -> String {
		let positions = runUntilStable(occupiedRule: 4)
		let result = positions.flatMap { $0 }.count(where: { $0 == "#" })
		return "\(result)"
	}

	public override func part2() -> String {
		let positions = runUntilStable(occupiedRule: 5, searchingFirstSeen: true)
		let result = positions.flatMap { $0 }.count(where: { $0 == "#" })
		return "\(result)"
	}

	private func runUntilStable(occupiedRule: Int, searchingFirstSeen: Bool = false) -> [[String]] {
		var positions = input.map { line in
			line.map { String($0) }
		}

		var changed = true
		while changed {
			var copy = positions
			changed = false
			for (y, row) in positions.enumerated() {
				for (x, tile) in row.enumerated() {
					let position = Position(x: x, y: y)

					let surroundingTiles = Position.surroundingDirections
						.compactMap({ searchingFirstSeen ? positions.firstWhile(from: position, along: $0, {  $0 == "." }) : position + $0 })
						.compactMap({ positions[safe: $0.y]?[safe: $0.x] })

					if tile == "L" {
						if surroundingTiles.count(where: { $0 == "#" }) == 0 {
							copy[position.y][position.x] = "#"
							changed = true
						}
					} else if tile == "#" {
						if surroundingTiles.count(where: { $0 == "#" }) >= occupiedRule {
							copy[position.y][position.x] = "L"
							changed = true
						}
					}
				}
			}

			positions = copy
		}

		return positions
	}
}
