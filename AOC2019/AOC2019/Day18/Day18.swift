import Foundation
import AdventOfCode

public final class Day18: Day {
	var grid: [[String]] = []
	var keys: [Position: String] = [:]

	public init(input: String = Input().trimmedRawInput()) {
		for line in input.lines {
			grid.append(line.exploded())
		}
	}

    public override func part1() -> String {
		printGrid()

		var player: Position!
		var gpos: Position!
		for (y, row) in grid.enumerated() {
			for (x, tile) in row.enumerated() {
				if tile == "g" {
					gpos = Position(x: x, y: y)
				} else if tile == "@" {
					player = Position(x: x, y: y)
				}
			}
		}

		let distance = shortestDistance(from: player, to: gpos, keyring: [])!
		print("distance ", distance)

        return ""
    }
    
    public override func part2() -> String {
		return ""
    }

	private func printGrid() {
		for line in grid {
			print(line.joined().replacingOccurrences(of: ".", with: " "))
		}
	}

	private func shortestDistance(from playerIndex: Position, to key: Position, keyring: [String]) -> Int? {
		var paths: [[Position]] = []
		var possiblePaths: [[Position]] = [[playerIndex]]

		while !possiblePaths.isEmpty {
			let path = possiblePaths.removeFirst()

			if path.last! == key {
				//print(path)
				paths.append(path)
			} else {
				for step in possibleSteps(from: path, to: key, keyring: keyring) {
					possiblePaths.append(path + [step])
				}
			}
		}

		if paths.isEmpty {
			return nil
		}

		print(paths.last!)

		return paths.min(by: { $0.count < $1.count })!.count
	}

	private func possibleSteps(from path: [Position], to key: Position, keyring: [String]) -> [Position] {
		let start = path.last!
		let possiblePositions = [start.north(), start.south(), start.west(), start.east()]
			.filter { !path.contains($0) }

		return possiblePositions.lazy.filter { position in
			if let tile = self.grid[safe: position.y]?[safe: position.x],
				tile == "." ||
				lowercaseLetters.contains(tile) ||
				(uppercaseLetters.contains(tile) && keyring.contains(tile)) {
				return true
			} else {
				return false
			}
		}
		//}.map { ($0, grid[$0.y][$0.x]) }
	}
}
