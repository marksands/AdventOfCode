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
		var changed = true
		while changed {
			let copy = matrix.copy()
			changed = false
			for (position, tile) in matrix.positions {
				let neighbors = searchingFirstSeen ?
					matrix.lineOfSightNeighbors(from: position, matching: { $0 == "#" || $0 == "L" }) :
					matrix.neighbors(from: position, matching: { $0 == "#" || $0 == "L" })

				if tile == "L" {
					if neighbors.count(where: { $0 == "#" }) == 0 {
						copy[position] = "#"
						changed = true
					}
				} else if tile == "#" {
					if neighbors.count(where: { $0 == "#" }) >= occupiedRule {
						copy[position] = "L"
						changed = true
					}
				}
			}

			matrix = copy
		}

		let result = matrix.positions.count(where: { $0.1 == "#" })
		return result
	}
}
