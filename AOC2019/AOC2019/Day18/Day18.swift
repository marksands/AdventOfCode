import Foundation
import AdventOfCode

struct Path: Hashable {
	var path: [Position]
	var keyring: Set<String>
	var player: Position
}

public final class Day18: Day {
	var grid: [[String]] = []
	var keysAtPosition: [Position: String] = [:]
	var keyPositions: [String: Position] = [:]

	public init(input: String = Input().trimmedRawInput()) {
		for line in input.lines {
			grid.append(line.exploded())
		}
	}

    public override func part1() -> String {
		printGrid()

		var player: Position!

		for (y, row) in grid.enumerated() {
			for (x, tile) in row.enumerated() {
				if lowercaseLetters.contains(tile) {
					keyPositions[tile] = Position(x: x, y: y)
					keysAtPosition[Position(x: x, y: y)] = tile
				} else if tile == "@" {
					player = Position(x: x, y: y)
					grid[y][x] = "." // remove player tile as barrier to pathfinding
				}
			}
		}

		let result = pathfind(from: player)
		print("---------- PATH ---------- ")
		print(result)

		let stepsRequired = result.path.count

		printPath(result)


		// NOTE: 113 is too low.

		return "\(stepsRequired)"
    }
    
    public override func part2() -> String {
		return ""
    }

	private func printGrid() {
		for line in grid {
			print(line.joined().replacingOccurrences(of: ".", with: " "))
		}
	}

	private func printPath(_ path: Path) {
		let allKeys = path.keyring.map { $0 }
			.filter { $0 != "." }
			.filter { $0 == $0.lowercased() }

		let allDoors = path.keyring.map { $0 }
			.filter { $0 != "." }
			.filter { $0 == $0.uppercased() }

		for (y, row) in grid.enumerated() {
			var resultLine = ""
			for (x, tile) in row.enumerated() {
				let p = Position(x: x, y: y)

				if allKeys.contains(tile) {
					resultLine += "K"
				} else if allDoors.contains(tile) {
					resultLine += "D"
				} else if path.path.contains(p) {
					resultLine += "x"
				} else if tile == "." {
					resultLine += " "
				} else {
					resultLine += tile
				}
			}
			print(resultLine)
		}
	}

	private func pathfind(from player: Position) -> Path {
		let allReachableKeysFromStartingPosition = keyPositions.values
			.compactMap { shortestPath(from: Path(path: [player], keyring: [], player: player), to: $0) }

		var possiblePaths = PriorityQueue<Path>(sort: { a, b in (-a.keyring.count, a.path.count) < (-b.keyring.count, b.path.count) })

		for path in allReachableKeysFromStartingPosition {
			possiblePaths.enqueue(path)
		}

		let allkeys = keyPositions.keys

		var biggestPath = allReachableKeysFromStartingPosition[0]

		while let path = possiblePaths.dequeue() {
			biggestPath = path.path.count > biggestPath.path.count ? path : biggestPath
			if allkeys.isContainedWithin(path.keyring) {
				return path
			} else {
				for newPath in self.possiblePaths(from: path) {
					possiblePaths.enqueue(newPath)
				}
			}
		}

		printPath(biggestPath)

		fatalError("You're algorithm is bad.")
	}

	private func possiblePaths(from path: Path) -> [Path] {
		let allReachableKeysFromStartingPosition = keyPositions.lazy
			.filter { kv in !path.keyring.contains(kv.key) }
			.compactMap { self.shortestPath(from: path, to: $0.value) }

		return Array(allReachableKeysFromStartingPosition)
	}

	private func shortestPath(from path: Path, to key: Position) -> Path? {
		var possiblePaths = PriorityQueue<Path>(sort: { a, b in (-a.keyring.count, a.path.count) < (-b.keyring.count, b.path.count) })

		possiblePaths.enqueue(path)

		while let path = possiblePaths.dequeue() {
			if path.player == key {
				// `player: key` -> new starting position is where the last key was found.
				print("Found shortest path to \(keysAtPosition[key]!)")
				return path
			} else {
				for (step, tile) in possibleSteps(from: path, to: key) {
					var newKeyring = path.keyring
					newKeyring.insert(tile)
					let possiblePath = Path(path: path.path + [step], keyring: newKeyring, player: step)

					possiblePaths.enqueue(possiblePath)
				}
			}
		}

		print("Missing key: \(keysAtPosition[key]!)")

		return nil
	}

	private func possibleSteps(from path: Path, to key: Position) -> [(Position, String)] {
		// TODO: this is bad if I have to retrace my steps—but will I ever retrace steps? In a perfect maze you will not.
		let possiblePositions = [path.player.north(), path.player.south(), path.player.west(), path.player.east()]
			.filter { !path.path.contains($0) }
		#warning("This filter is flawed, since I must retrace my steps to navigate between all 4 qudrants. Figure out a solution.")

		return possiblePositions.lazy.filter { position in
			if let tile = self.grid[safe: position.y]?[safe: position.x], tile == "." || self.isKey(tile) || self.hasKeyForDoor(path.keyring, door: tile) {
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
