import Foundation
import AdventOfCode

enum Direction: String, CaseIterable {
	case nw
	case ne
	case w
	case e
	case sw
	case se

	// HEX
	//   7   2
	//
	// 6   1   3
	//
	//   5   4

	// Array (turn your head 45º clockwise)
	// 2 3
	// 7 1 4
	//   6 5

	func moving(from value: Position) -> Position {
		switch self {
		case .nw: return value.west()
		case .ne: return value.north().west()
		case .w: return value.south()
		case .e: return value.north()
		case .sw: return value.south().east()
		case .se: return value.east()
		}
	}
}

public final class Day24: Day {
	private var input: String = ""

	public init(input: String = Input().trimmedRawInput()) {
		super.init()
		self.input = input
	}

	public override func part1() -> String {
		var directions: [[Direction]] = []

		var tiles: [Position: Bool] = [:]

		for line in input.lines {
			var direction: [Direction] = []
			var character = ""
			for char in line.exploded() {
				character += char
				if Direction.allCases.map({ $0.rawValue }).contains(character) {
					direction.append(Direction(rawValue: character)!)
					character = ""
				}
			}
			directions.append(direction)
		}

		for path in directions {
			var reference = Position.zero
			for direction in path {
				reference = direction.moving(from: reference)
			}

			tiles[reference, default: false].toggle()
		}

		let blackCount = tiles.values.count(where: { $0 })

		return "\(blackCount)"
	}

	public override func part2() -> String {
		var directions: [[Direction]] = []

		var tiles: [Position: Bool] = [:]

		for line in input.lines {
			var direction: [Direction] = []
			var character = ""
			for char in line.exploded() {
				character += char
				if Direction.allCases.map({ $0.rawValue }).contains(character) {
					direction.append(Direction(rawValue: character)!)
					character = ""
				}
			}
			directions.append(direction)
		}

		for path in directions {
			var reference = Position.zero
			for direction in path {
				reference = direction.moving(from: reference)
				tiles[reference] = tiles[reference, default: false]

				Direction.allCases
					.map { $0.moving(from: reference) }
					.forEach { tiles[$0] = tiles[$0, default: false] }
			}

			tiles[reference]!.toggle()
		}

		for _ in (0..<100) {
			// mark

			var tileToNeighborCount: [Position: Int] = [:]

			for kv in tiles {
				let neighborCount = Direction.allCases
					.map { $0.moving(from: kv.key) }
					.map { d -> Bool in
						tiles[d] = tiles[d, default: false] // ;_;
						return tiles[d]!
					}
					.count(where: { $0 })

				tileToNeighborCount[kv.key] = neighborCount
			}

			// sweep

			for kv in tiles {
				if kv.value && (tileToNeighborCount[kv.key, default: 0] == 0 || tileToNeighborCount[kv.key, default: 0] > 2) {
					tiles[kv.key] = false
				} else if !kv.value && tileToNeighborCount[kv.key, default: 0] == 2 {
					tiles[kv.key] = true
				}
			}
		}

		let blackCount = tiles.values.count(where: { $0 })

		return "\(blackCount)"
	}
}
