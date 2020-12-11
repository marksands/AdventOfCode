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
		let result = positions.count(where: { $0.1 == "#" })
		return "\(result)"
	}

	public override func part2() -> String {
		let positions = runUntilStable(occupiedRule: 5, searchingFirstSeen: true)
		let result = positions.count(where: { $0.1 == "#" })
		return "\(result)"
	}

	private func runUntilStable(occupiedRule: Int, searchingFirstSeen: Bool = false) -> [Position: Character] {
		var positions: [Position: Character] = [:]

		input.enumerated().forEach { y, line in
			line.enumerated().forEach { x, tile in
				positions[Position(x: x, y: y)] = tile
			}
		}

		var changed = true
		while changed {
			var copy = positions
			changed = false
			for (position, tile) in positions {
				let surroundingTiles = Position.surroundingDirections
					.compactMap({ searchingFirstSeen ? positions.firstWhile(from: position, along: $0, { $0 == "." }) : position + $0 })
					.compactMap({ positions[$0] })

				if tile == "L" {
					if surroundingTiles.count(where: { $0 == "#" }) == 0 {
						copy[position] = "#"
						changed = true
					}
				} else if tile == "#" {
					if surroundingTiles.count(where: { $0 == "#" }) >= occupiedRule {
						copy[position] = "L"
						changed = true
					}
				}
			}

			positions = copy
		}

		return positions
	}
}
