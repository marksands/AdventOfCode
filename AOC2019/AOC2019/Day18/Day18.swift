import Foundation
import AdventOfCode

struct Path: Hashable {
	var path: [Position]
	var keyring: Set<String>
}

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
		var keyPositions: [String: Position] = [:]

		for (y, row) in grid.enumerated() {
			for (x, tile) in row.enumerated() {
				if lowercaseLetters.contains(tile) {
					keyPositions[tile] = Position(x: x, y: y)
				} else if tile == "@" {
					player = Position(x: x, y: y)
					grid[y][x] = "." // remove player tile as barrier to pathfinding
				}
			}
		}

//		let path = shortestPath(from: player, to: keyPositions["g"]!, keyring: [])!
//		print("path to g: ", path.path.count)

//		let path2 = shortestPath(from: player, to: keyPositions["x"]!, keyring: [])!
//		print("path to x: ", path2.path.count)

		let path3 = shortestPath(from: player, to: keyPositions["c"]!, keyring: [])!
		print(path3)
		print("path to c: ", path3.path.count)

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

	private func shortestPath(from playerIndex: Position, to key: Position, keyring: [String]) -> Path? {
		var paths: [Path] = []
		var possiblePaths = [Path(path: [playerIndex], keyring: Set(keyring))]

		while !possiblePaths.isEmpty {
			let path = possiblePaths.removeFirst()

			if path.path.last! == key {
				//print(path)
				paths.append(path)
			} else {
				for (step, tile) in possibleSteps(from: path, to: key, keyring: path.keyring) {
					var newKeyring = path.keyring
					newKeyring.insert(tile)
					possiblePaths.append(Path(path: path.path + [step], keyring: newKeyring))
				}
			}
		}

		return paths.min(by: { $0.path.count < $1.path.count })
	}

	// need to serialize paths, such that I only search and return unique paths. filter { !path.path.contains($0) } is flawed
	// in this way because this can lead to infinite paths.
	// if I have ALL possible paths in some sort of cache, I can check if the serialzied path does not contain this.
	private func possibleSteps(from path: Path, to key: Position, keyring: Set<String>) -> [(Position, String)] {
		let start = path.path.last!
		let possiblePositions = [start.north(), start.south(), start.west(), start.east()]
			.filter { !path.path.contains($0) } // TODO: this is bad for when I have to retrace my steps!!!

		return possiblePositions.lazy.filter { position in
			if let tile = self.grid[safe: position.y]?[safe: position.x], tile == "." || self.isKey(tile) || self.hasKeyForDoor(keyring, door: tile) {
				return true
			} else {
				return false
			}
		}.map { ($0, grid[$0.y][$0.x]) }
	}

	@inline(__always)
	private func isKey(_ tile: String) -> Bool {
		return lowercaseLetters.contains(tile)
	}

	@inline(__always)
	private func hasKeyForDoor(_ keyring: Set<String>, door: String) -> Bool {
		return keyring.contains(door.lowercased()) && uppercaseLetters.contains(door)
	}
}
