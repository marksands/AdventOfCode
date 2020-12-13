import Foundation
import AdventOfCode

public final class Day11: Day {
	private var input: [String] = []

	private var matrix: Matrix<Character>

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.matrix = Matrix(input.map { $0.map { $0 } })
		super.init()
		self.input = input
	}

	public override func part1() -> String {
		return "\(occupiedCountWhenStable(occupiedRule: 4))"
	}

	public override func part2() -> String {
		return "\(occupiedCountWhenStable(occupiedRule: 5, searchingFirstSeen: true))"
	}

	private func occupiedCountWhenStable(occupiedRule: Int, searchingFirstSeen: Bool = false) -> Int {
		while true {
			let copy = matrix.copy()
			for (position, tile) in matrix.positions {
				let neighbors = searchingFirstSeen ?
					matrix.lineOfSightNeighbors(from: position, matching: Day11.isSeat) :
					matrix.neighbors(from: position, matching: Day11.isSeat)

				if tile == "L", neighbors.count(where: Day11.isOccupied) == 0 {
					copy[position] = "#"
				} else if tile == "#", neighbors.count(where: Day11.isOccupied) >= occupiedRule {
					copy[position] = "L"
				}
			}

			if matrix == copy { break }
			matrix = copy
		}

		let result = matrix.positions.count(where: { Day11.isOccupied($0.1) })
		return result
	}

	private static func isSeat(_ tile: Character) -> Bool {
		return tile == "#" || tile == "L"
	}

	private static func isOccupied(_ tile: Character) -> Bool {
		return tile == "#"
	}
}
