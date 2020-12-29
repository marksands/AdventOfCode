import Foundation
import AdventOfCode

struct Path: Hashable {
	//var keyring: Set<Character>
	var keyMask: Int
	var player: Position
	var steps: Int
}

struct PathCache: Hashable {
	var player: Position
	//var keys: Set<Character>
	var keyMask: Int
}

func maskValueForTile(_ char: Character) -> Int {
	let value = (char.asciiValue ?? 0) &- 97
	if value > 26 || value < 0 { return 0 }
	return (1 << value)
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


		let result = pathfind(from: player)
		print("---------- PATH ---------- ")
		print(result)

		let stepsRequired = result.steps

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

	private func pathfind(from player: Position) -> Path {
		let possiblePaths = LinkedList<Path>([Path(keyMask: 0, player: player, steps: 0)])

		let allKeysMask = lowercaseLetters.reduce(0) { $0 | maskValueForTile($1) }
		print("Key Mask: ", allKeysMask)

		while let path = possiblePaths.popFirst() {
			if allKeysMask & path.keyMask == allKeysMask {
				return path
			} else {
				for (step, tile) in possibleSteps(from: path) {
					let possiblePath = Path(keyMask: path.keyMask | maskValueForTile(tile), player: step, steps: path.steps + 1)

					if seen.insert(PathCache(player: step, keyMask: path.keyMask | maskValueForTile(tile))).inserted {
						possiblePaths.append(possiblePath)
					}
				}
			}
		}

		fatalError("You're algorithm is bad.")
	}

	private func possibleSteps(from path: Path) -> [(Position, Character)] {
		let steps: [(Position, Character)] = [path.player.north(), path.player.south(), path.player.west(), path.player.east()]
			.lazy
			.filter { $0.x >= 0 && $0.x < self.grid[0].count && $0.y >= 0 && $0.y < self.grid.count }
			.map { ($0, self.grid[$0.y][$0.x]) }
		return steps.filter { (pos, tile) -> Bool in tile == "." || self.isKey(tile) || self.hasKeyForDoor(path.keyMask, door: tile) }
	}

	@inline(__always)
	private func isKey(_ tile: Character) -> Bool {
		return tile.isLowercase
	}

	@inline(__always)
	private func hasKeyForDoor(_ keyMask: Int, door: Character) -> Bool {
		return door.isUppercase && (maskValueForTile(Character(door.lowercased())) & keyMask == maskValueForTile(Character(door.lowercased())))
		//return isContainedWithin([Character(door.lowercased())], keyring) && door.isUppercase
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

