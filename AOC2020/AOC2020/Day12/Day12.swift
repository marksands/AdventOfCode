import Foundation
import AdventOfCode

public final class Day12: Day {
	private var input: [String] = []

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		super.init()
		self.input = input
	}

	public override func part1() -> String {
		var direction = Heading.east
		var position = Position.zero

		for line in input {
			let (action, number) = (String(line.prefix(1)), Int(line.dropFirst())!)
			
			let headingActions = [
				"N": Heading.north,
				"S": Heading.south,
				"E": Heading.east,
				"W": Heading.west,
				"F": direction
			]

			let turningActions = [
				"L": { direction.turnLeft() },
				"R": { direction.turnRight() }
			]

			if let positionAction = headingActions[action] {
				position = number.times.reduce(position) { p, _ in p.advanced(toward: positionAction) }
			} else if let turnAction = turningActions[action] {
				(number / 90).times.forEach { turnAction() }
			}
		}

		let result = position.manhattanDistance(to: .zero)
		return String(result)
	}

	public override func part2() -> String {
		var position = Position.zero
		var wpPosition = Position(x: 10, y: -1)

		for line in input {
			let (action, number) = (String(line.prefix(1)), Int(line.dropFirst())!)

			let headingActions = [
				"N": Heading.north,
				"S": Heading.south,
				"E": Heading.east,
				"W": Heading.west
			]

			let turningActions = [
				"L": { (p: Position) in p.rotatedLeft() },
				"R": { (p: Position) in p.rotatedRight() }
			]

			if let positionAction = headingActions[action] {
				wpPosition = number.times.reduce(wpPosition) { p, _ in p.advanced(toward: positionAction) }
			} else if let turnAction = turningActions[action] {
				wpPosition = (number/90).times.reduce(wpPosition) { p, _ in turnAction(p) }
			} else if action == "F" {
				position = Position(x: position.x + (wpPosition.x * number), y: position.y + (wpPosition.y * number))
			}
		}

		let result = position.manhattanDistance(to: Position.zero)
		return String(result)
	}
}
