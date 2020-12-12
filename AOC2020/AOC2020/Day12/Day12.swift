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
				"N": { ship = number.times.reduce(ship) { p, _ in p.advanced(toward: .north) } },
				"S": { ship = number.times.reduce(ship) { p, _ in p.advanced(toward: .south) } },
				"E": { ship = number.times.reduce(ship) { p, _ in p.advanced(toward: .east) } },
				"W": { ship = number.times.reduce(ship) { p, _ in p.advanced(toward: .west) } },
				"F": { ship = number.times.reduce(ship) { p, _ in p.advanced(toward: direction) } },
				"L": { (number / 90).times.forEach { direction.turnLeft() } },
				"R": { (number / 90).times.forEach { direction.turnRight() } }
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
				"N": { waypoint = number.times.reduce(waypoint) { p, _ in p.advanced(toward: .north) } },
				"S": { waypoint = number.times.reduce(waypoint) { p, _ in p.advanced(toward: .south) } },
				"E": { waypoint = number.times.reduce(waypoint) { p, _ in p.advanced(toward: .east) } },
				"W": { waypoint = number.times.reduce(waypoint) { p, _ in p.advanced(toward: .west) } },
				"L": { waypoint = (number/90).times.reduce(waypoint) { p, _ in p.rotatedLeft() } },
				"R": { waypoint = (number/90).times.reduce(waypoint) { p, _ in p.rotatedRight() } },
				"F": { ship = ship + Position(x: waypoint.x * number, y: waypoint.y * number) }
			][action]!()
		}
		return String(ship.manhattanDistance(to: .zero))
	}
}
