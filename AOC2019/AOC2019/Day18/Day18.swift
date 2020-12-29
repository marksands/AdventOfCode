import Foundation
import AdventOfCode

struct Path: Hashable {
	var keyring: Set<Character>
	var player: Position
	var steps: Int
}

struct PathCache: Hashable {
	var player: Position
	var keys: Set<Character>
}

public final class Day18: Day {
	var grid: [[Character]] = []
	var keysAtPosition: [Position: Character] = [:]
	var keyPositions: [Character: Position] = [:]

	var seen: Set<PathCache> = []

	public init(input: String = Input().trimmedRawInput()) {
		for line in input.lines {
			var row: [Character] = []
			for c in line {
				row.append(c)
			}
			grid.append(row)
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

//		let short = shortestPath(from: Path(path: [player], keyring: [], player: player), to: keyPositions["g"]!)!
//		print(short)
//		print(short.path.count)
//		return ""

		let result = pathfind(from: player)
		print("---------- PATH ---------- ")
		print(result)

		let stepsRequired = result.steps

		// TODO: (Array+append is too slow. Whole thing runs in about 75 minutes)
//		printPath(result)

		return "\(stepsRequired)"
    }
    
    public override func part2() -> String {
		return ""
    }

	private func printGrid() {
		for line in grid {
			print(line.map { String($0) }.joined().replacingOccurrences(of: ".", with: " "))
		}
	}

//	private func printPath(_ path: Path) {
//		let allKeys = path.keyring.map { $0 }
//			.filter { $0 != "." }
//			.filter { String($0) == String($0).lowercased() }
//
//		let allDoors = path.keyring.map { $0 }
//			.filter { $0 != "." }
//			.filter { String($0) == String($0).uppercased() }
//
//		for (y, row) in grid.enumerated() {
//			var resultLine = ""
//			for (x, tile) in row.enumerated() {
//				let p = Position(x: x, y: y)
//
//				if allKeys.contains(tile) {
//					resultLine += "K"
//				} else if allDoors.contains(tile) {
//					resultLine += "D"
//				} else if path.path.contains(p) {
//					resultLine += "x"
//				} else if tile == "." {
//					resultLine += " "
//				} else {
//					resultLine += String(tile)
//				}
//			}
//			print(resultLine)
//		}
//	}

	private func pathfind(from player: Position) -> Path {
		var possiblePaths = LinkedList<Path>([Path(keyring: [], player: player, steps: 0)])

		// NOTE: It performed 30 200 000 iterations

		let allkeys = keyPositions.keys.sorted()

		var c = 0

		while let path = possiblePaths.popFirst() {
//			if ["a"].isContainedWithin(path.keyring) {
			if isContainedWithin(allkeys, path.keyring) {
				return path
			} else {
//				for possiblePath in self.possiblePaths(from: path) {
//					c += 1
//
//					possiblePaths.append(possiblePath)
//
//					if c % 10_000 == 0 {
//						print("step \(c)...")
//					}
//				}
				for (step, tile) in possibleSteps(from: path) {
					var newKeyring = path.keyring
					newKeyring.insert(tile)
					//let possiblePath = Path(path: path.path + [step], keyring: newKeyring, player: step)
					let possiblePath = Path(keyring: newKeyring, player: step, steps: path.steps + 1)

					if seen.insert(PathCache(player: step, keys: newKeyring)).inserted {
						c += 1

						possiblePaths.append(possiblePath)

						if c % 100_000 == 0 {
							print("step \(c)...")
						}
					}
				}
			}
		}

		fatalError("You're algorithm is bad.")
	}

//	private func possiblePaths(from path: Path) -> [Path] {
//		let allReachableKeysFromStartingPosition = keyPositions.lazy
//			.filter { kv in !path.keyring.contains(kv.key) }
//			.compactMap { self.shortestPath(from: path, to: $0.value) }
//
//		return Array(allReachableKeysFromStartingPosition)
//	}
//
//	var c = 0

//	private func shortestPath(from path: Path, to key: Position) -> Path? {
//		var possiblePaths = [path]
//
//		if let path = pathCache[Double(p: path.player, p2: key)] { return path }
//
//		while let path = possiblePaths.popFirst() {
//			if path.player == key {
//				// `player: key` -> new starting position is where the last key was found.
//				print("Found shortest path to \(keysAtPosition[key]!)")
//				return path
//			} else {
//				for (step, tile) in possibleSteps(from: path) {
//					var newKeyring = path.keyring
//					newKeyring.insert(tile)
//					let possiblePath = Path(keyring: newKeyring, player: step, steps: path.steps + 1)
//
//					if seen.insert(PathCache(player: step, keys: newKeyring)).inserted {
//						possiblePaths.append(possiblePath)
//						c += 1
//						if c % 100_000 == 0 {
//							print("step \(c)...")
//						}
//					}
//				}
//			}
//		}
//
//		return nil
//	}
//
	private func possibleSteps(from path: Path) -> [(Position, Character)] {
		let steps: [(Position, Character)] = [path.player.north(), path.player.south(), path.player.west(), path.player.east()]
			.lazy
			.filter { $0.x >= 0 && $0.x < self.grid[0].count && $0.y >= 0 && $0.y < self.grid.count }
			.map { ($0, self.grid[$0.y][$0.x]) }
		return steps.filter { (pos, tile) -> Bool in tile == "." || self.isKey(tile) || self.hasKeyForDoor(path.keyring, door: tile) }
	}

	@inline(__always)
	private func isKey(_ tile: Character) -> Bool {
		return tile.isLowercase
	}

	@inline(__always)
	private func hasKeyForDoor(_ keyring: Set<Character>, door: Character) -> Bool {
		return isContainedWithin([Character(door.lowercased())], keyring) && door.isUppercase
		//return keyring.contains(Character(door.lowercased())) && uppercaseLetters.contains(door)
	}

	private func isContainedWithin(_ sortedSelf: [Character], _ other: Set<Character>) -> Bool {
		guard sortedSelf.count > 0 else { return false }
		guard other.count > 0 else { return false }

		let sortedOther = other.sorted()

		var i = 0
		var j = 0

		var elementsEqual = 0

		while i < sortedSelf.count && j < sortedOther.count {
			if sortedSelf[i] < sortedOther[j] {
				i += 1
			} else if sortedSelf[i] > sortedOther[j] {
				j += 1
			} else {
				elementsEqual += 1
				i += 1
				j += 1
			}
		}

		return elementsEqual == sortedSelf.count
	}
}

