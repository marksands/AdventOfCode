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
		var ship = Position.zero

		for line in input {
			let (action, number) = (String(line.prefix(1)), Int(line.dropFirst())!)
			[
				"N": { ship.advance(toward: .north, times: number) },
				"S": { ship.advance(toward: .south, times: number) },
				"E": { ship.advance(toward: .east, times: number) },
				"W": { ship.advance(toward: .west, times: number) },
				"L": { (number / 90).times.forEach { direction.turnLeft() } },
				"R": { (number / 90).times.forEach { direction.turnRight() } },
				"F": { ship.advance(toward: direction, times: number) },
			][action]!()
		}
		return String(ship.manhattanDistance(to: .zero))
	}

	public override func part2() -> String {
		var ship = Position.zero
		var waypoint = Position(x: 10, y: -1)

		for line in input {
			let (action, number) = (String(line.prefix(1)), Int(line.dropFirst())!)
			[
				"N": { waypoint.advance(toward: .north, times: number) },
				"S": { waypoint.advance(toward: .south, times: number) },
				"E": { waypoint.advance(toward: .east, times: number) },
				"W": { waypoint.advance(toward: .west, times: number) },
				"L": { (number / 90).times.forEach { waypoint.rotateLeft() } },
				"R": { (number / 90).times.forEach { waypoint.rotateRight() } },
				"F": { ship = ship + Position(x: waypoint.x * number, y: waypoint.y * number) }
			][action]!()
		}
		return String(ship.manhattanDistance(to: .zero))
	}
}
