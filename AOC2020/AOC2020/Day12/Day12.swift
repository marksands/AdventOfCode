import Foundation
import AdventOfCode

public final class Day12: Day {
	private var input: [String] = []

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		super.init()
		self.input = input
	}

	func degreesToRadians(_ degrees: Float) -> Float {
		return degrees * .pi / 180
	}

	enum FacingDirection {
		case north
		case east
		case south
		case west

		mutating func turnRight() {
			switch self {
			case .north: self = .east
			case .east: self = .south
			case .south: self = .west
			case .west: self = .north
			}
		}

		mutating func turnLeft() {
			switch self {
			case .north: self = .west
			case .east: self = .north
			case .south: self = .east
			case .west: self = .south
			}
		}

		func advanced(position: Position) -> Position {
			switch self {
			case .north:
				return position.north()
			case .east:
				return position.east()
			case .south:
				return position.south()
			case .west:
				return position.west()
			}
		}
	}

	public override func part1() -> String {
		var direction = FacingDirection.east
		var position = Position.zero

		for line in input {
			let action = line.prefix(1)
			let number = Int(line.dropFirst())!

			if action == "N" {
				(0..<number).forEach {_ in
					position = position.north()
				}

			} else if action == "S" {
				(0..<number).forEach {_ in
					position = position.south()
				}

			} else if action == "E" {
				(0..<number).forEach {_ in
					position = position.east()
				}

			} else if action == "W" {
				(0..<number).forEach {_ in
					position = position.west()
				}

			} else if action == "L" {
				let turns = number / 90
				(0..<turns).forEach { _ in direction.turnLeft() }

			} else if action == "R" {
				let turns = number / 90
				(0..<turns).forEach { _ in direction.turnRight() }

			} else if action == "F" {
				(0..<number).forEach {_ in
					position = direction.advanced(position: position)
				}
			}
		}

		let result = position.manhattanDistance(to: Position.zero)
		return String(result)
	}

	public override func part2() -> String {
		var position = Position.zero
		var wpPosition = Position(x: 10, y: -1)

		for line in input {
			let action = line.prefix(1)
			let number = Int(line.dropFirst())!

			if action == "N" {
				(0..<number).forEach {_ in
					wpPosition = wpPosition.north()
				}
			} else if action == "S" {
				(0..<number).forEach {_ in
					wpPosition = wpPosition.south()
				}
			} else if action == "E" {
				(0..<number).forEach {_ in
					wpPosition = wpPosition.east()
				}
			} else if action == "W" {
				(0..<number).forEach {_ in
					wpPosition = wpPosition.west()
				}
			} else if action == "L" {
				for _ in (0..<number/90) {
					wpPosition = wpPosition.rotatedLeft()
				}
			} else if action == "R" {
				for _ in (0..<number/90) {
					wpPosition = wpPosition.rotatedRight()
				}
			} else if action == "F" {
				position = Position(x: position.x + (wpPosition.x * number), y: position.y + (wpPosition.y * number))
			}
		}

		let result = position.manhattanDistance(to: Position.zero)
		return String(result) // not 102913
	}
}
