import Foundation
import AdventOfCode

func rotated(_ matrix: [String], _ clockwiseTurns: Int) -> [String] {
	let turns = clockwiseTurns % 4
	if turns == 0 { return matrix }

	var current = matrix.map { $0.map { $0 as Character } }
	for _ in (0..<turns) {
		var thisTurn: [[Character]] = []
		for i in (0..<current[0].count) {
			var newRow: [Character] = []
			for row in current.reversed() {
				newRow.append(row[i])
			}
			thisTurn.append(newRow)
		}
		current = thisTurn
	}
	return current.map { $0.map { String($0) }.joined() }
}

func flippedHorizontally(_ matrix: [String]) -> [String] {
	var flipped: [String] = []
	for row in matrix {
		flipped.append(String(row.reversed()))
	}
	return flipped
}

func flippedVertically(_ matrix: [String]) -> [String] {
	return rotated(flippedHorizontally(rotated(matrix, 1)), 3)
}

func rotatedAndFlipped(_ matrix: [String]) -> [[String]] {
	let mutations = (0...3).flatMap { i -> [[String]] in
		let m = rotated(matrix, i)
		return [m, flippedHorizontally(m), flippedVertically(m)]
	}
	return mutations
}

func insetLinesByOne(_ lines: [String]) -> [String] {
	let copy = Array(lines.dropFirst().dropLast())
	var newLines: [String] = []
	for line in copy {
		newLines.append(String(line.dropFirst().dropLast()))
	}
	return newLines
}

/// concatenates [a] and [b] assuming the row count are the same dimension
func concatenate(_ a: [String], _ b: [String]) -> [String] {
	guard a.count == b.count else { fatalError("A's row count must match B's row count!") }

	let newMatrix = zip(a, b).map { left, right in
		left + right
	}

	return newMatrix
}

struct Tile: Hashable {
	let id: Int
	var matrix: [String]

	var topEdge: String {
		return matrix[0]
	}

	var bottomEdge: String {
		return matrix.last!
	}

	var leftEdge: String {
		return matrix.map { String($0[unsafe: 0]) }.joined()
	}

	var rightEdge: String {
		let width = matrix[0].count
		return matrix.map { String($0[unsafe: width-1]) }.joined()
	}
}

public final class Day20: Day {
	private var input: String = ""
	private var tiles: [Tile] = []

	public init(input: String = Input().trimmedRawInput()) {
		super.init()
		self.input = input
	}

	public override func part1() -> String {
		let rawTiles = input.groups

		for rawTile in rawTiles {
			let tileId = Int(rawTile.lines[0].dropFirst(5).dropLast())!
			let lines = Array(rawTile.lines.dropFirst())
			tiles.append(Tile(id: tileId, matrix: lines))
		}

		// do a BFS from all tiles
		// each neighbor are all tiles that have valid rotations that match up along all sides.

		var possibleTilePositions = PriorityQueue<[[Tile]]>(sort: { $0.count > $1.count })

		// except only for corner tiles
		let allRotatedTiles = tiles
			.flatMap { t in
				rotatedAndFlipped(t.matrix).map { m in
					Tile(id: t.id, matrix: m)
				}
			 }
			.filter { cornerIds.contains($0.id) }

		for tile in allRotatedTiles {
			var queue = PriorityQueue<[[Tile]]>(sort: { $0.count > $1.count })
			queue.enqueue([[tile]])

			while queue.count > 0 {
				let path = queue.dequeue()!

				if path.flatMap({ $0 }).count == tiles.count { // max, found it
					possibleTilePositions.enqueue(path)

					let found = possibleTilePositions.dequeue()!
//					let result = found[0][0].id * found[2][0].id * found[2][2].id * found[0][2].id
					 let result = found[0][0].id * found[11][0].id * found[11][11].id * found[0][11].id
					return "\(result)"
				}

				for possiblePath in possiblePaths(of: path) {
					queue.enqueue(possiblePath)
				}
			}
		}

		return ""
	}

	public override func part2() -> String {
		let rawTiles = input.groups

		for rawTile in rawTiles {
			let tileId = Int(rawTile.lines[0].dropFirst(5).dropLast())!
			let lines = Array(rawTile.lines.dropFirst())
			tiles.append(Tile(id: tileId, matrix: lines))
		}

		// do a BFS from all tiles
		// each neighbor are all tiles that have valid rotations that match up along all sides.

		var possibleTilePositions = PriorityQueue<[[Tile]]>(sort: { $0.count > $1.count })

		let allRotatedTiles = tiles
			.flatMap { t in
				rotatedAndFlipped(t.matrix).map { m in
					Tile(id: t.id, matrix: m)
				}
			 }
			.filter { cornerIds.contains($0.id) }

//		var foundFirst = false

		for tile in allRotatedTiles {
//			if foundFirst { break }
			var queue = PriorityQueue<[[Tile]]>(sort: { $0.count > $1.count })
			queue.enqueue([[tile]])

			while queue.count > 0 {
				let path = queue.dequeue()!

				if path.flatMap({ $0 }).count == tiles.count { // max, found it
					possibleTilePositions.enqueue(path)
//					foundFirst = true
					break
				}

				for possiblePath in possiblePaths(of: path) {
					queue.enqueue(possiblePath)
				}
			}
		}

		func printDebuggedMonster(y: Int, x: Int, matrix flattenedMatrix: [String]) {
			var flattenedMatrix2 = flattenedMatrix.map { (n: String) -> [String] in n.map { String($0) } }

			flattenedMatrix2[y][x] = "O"
			flattenedMatrix2[y + 1][x - 1] = "O"
			flattenedMatrix2[y + 1][x] = "O"
			flattenedMatrix2[y + 1][x + 1] = "O"
			flattenedMatrix2[y + 1][x - 6] = "O"
			flattenedMatrix2[y + 1][x - 7] = "O"
			flattenedMatrix2[y + 1][x - 12] = "O"
			flattenedMatrix2[y + 1][x - 13] = "O"
			flattenedMatrix2[y + 1][x - 18] = "O"
			flattenedMatrix2[y + 2][x - 2] = "O"
			flattenedMatrix2[y + 2][x - 5] = "O"
			flattenedMatrix2[y + 2][x - 8] = "O"
			flattenedMatrix2[y + 2][x - 11] = "O"
			flattenedMatrix2[y + 2][x - 14] = "O"
			flattenedMatrix2[y + 2][x - 17] = "O"

			print("----<NESSIE>----")
			for line in flattenedMatrix2.map({ $0.joined() }) {
				print(line)
			}
			print("----</NESSIE>----")
		}

		func tileContainsMonster(y: Int, x: Int, matrix flattenedMatrix: [String]) -> Bool {

			if flattenedMatrix[safe: y]?[safe: x] == "#", // top-of-head
				// mouth
			   flattenedMatrix[safe: y + 1]?[safe: x - 1] == "#",
			   flattenedMatrix[safe: y + 1]?[safe: x] == "#",
			   flattenedMatrix[safe: y + 1]?[safe: x + 1] == "#",

				// torso (middle row)
			   flattenedMatrix[safe: y + 1]?[safe: x - 6] == "#",
			   flattenedMatrix[safe: y + 1]?[safe: x - 7] == "#",
			   flattenedMatrix[safe: y + 1]?[safe: x - 12] == "#",
			   flattenedMatrix[safe: y + 1]?[safe: x - 13] == "#",
			   flattenedMatrix[safe: y + 1]?[safe: x - 18] == "#",

				// bottom (last row)
			   flattenedMatrix[safe: y + 2]?[safe: x - 2] == "#",
			   flattenedMatrix[safe: y + 2]?[safe: x - 5] == "#",
			   flattenedMatrix[safe: y + 2]?[safe: x - 8] == "#",
			   flattenedMatrix[safe: y + 2]?[safe: x - 11] == "#",
			   flattenedMatrix[safe: y + 2]?[safe: x - 14] == "#",
			   flattenedMatrix[safe: y + 2]?[safe: x - 17] == "#" {
				return true
			} else {
				return false
			}
		}

		var monstersFound: [Int] = []

		while let found = possibleTilePositions.dequeue() {
			var newRows: [String] = []
			for row in found {
				let concatenatedRow = row.dropFirst().reduce(insetLinesByOne(row.first!.matrix)) { seed, next in
					concatenate(seed, insetLinesByOne(next.matrix))
				}
				var result = ""
				for row in concatenatedRow {
					result += row
					result += "\n"
				}
				newRows.append(String(result.dropLast())) // clip trailing newline
			}

//			for row in newRows {
//				print(row)
//			}

			let mutations = rotatedAndFlipped(newRows)

			for mutatedRow in mutations {
				let flattenedMutation = mutatedRow.reduce([]) { $0 + $1.lines }

				var monsterFound = 0
				for (y, row) in flattenedMutation.enumerated() {
					if y >= 6 && monsterFound < 2 { // efficiency test
						break
					}
					for (x, _) in row.enumerated() {
						if tileContainsMonster(y: y, x: x, matrix: flattenedMutation) {
							monsterFound += 1
//							printDebuggedMonster(y: y, x: x, matrix: flattenedMutation)
						}
					}
				}

				if monsterFound > 0 {
					print("FOUND: \(monsterFound)")
					monstersFound.append(monsterFound)
				} else {
					print("--SKIPPING MUTATION--")
				}

				monsterFound = 0
//					monstersFound = 0 // reset, I'll try a few variants I guess?
			}
		}
		print("sampled: \(monstersFound)")
		// 2589 - (X * 14) // x = found
		return ""
	}

	// using this as a way to make the neighbors efficient.
//	let cornerIds = [1951, 3079, 2971, 1171] // example input
	let cornerIds = [1301, 1373, 1289, 3593] // my input

	func nextPossibleTileIsACorner(_ route: [[Tile]]) -> Bool {
		// will only be 3 conditions, since the first initial one will always be the top-left
		let firstRowFarRight = (route.count == 1 && route[0].count == 11)
		let lastRowFarLeft = (route.count == 11 && route[10].count == 12)
		let lastRowFarRight = (route.count == 12 && route[11].count == 11)
		let isACorner = firstRowFarRight || lastRowFarLeft || lastRowFarRight
		return isACorner
	}

//	func nextPossibleTileIsACorner(_ route: [[Tile]]) -> Bool {
//		// will only be 3 conditions, since the first initial one will always be the top-left
//		let firstRowFarRight = (route.count == 1 && route[0].count == 2)
//		let lastRowFarLeft = (route.count == 2 && route[1].count == 3)
//		let lastRowFarRight = (route.count == 3 && route[2].count == 2)
//		let isACorner = firstRowFarRight || lastRowFarLeft || lastRowFarRight
//		return isACorner
//	}

	func possiblePaths(of route: [[Tile]]) -> [[[Tile]]] {
		let initialRouteTiles = route.flatMap { $0 }.map { $0.id }
		var remainingTiles = self.tiles.filter { !initialRouteTiles.contains($0.id) }

		if nextPossibleTileIsACorner(route) {
			remainingTiles = remainingTiles.filter { cornerIds.contains($0.id) }
		}

		var newPaths: [[[Tile]]] = []

		if route.last!.count < 12 { // change me 3 or 12
			// extend right
			let rightMostTile = route.last!.last!

			let rotatedRemainingTiles = remainingTiles
				.flatMap { t in
					rotatedAndFlipped(t.matrix).map { m in
						Tile(id: t.id, matrix: m)
					}
				}

			let topTile: Tile? = route[safe: route.count - 1 - 1]?[safe: route.last!.count]
			let rightEdge = rightMostTile.rightEdge

			let possibleTiles = rotatedRemainingTiles.filter { remainingTile in
				if let tt = topTile {
					return remainingTile.topEdge == tt.bottomEdge && remainingTile.leftEdge == rightEdge
				} else {
					return remainingTile.leftEdge == rightEdge
				}
			}

			let possiblePaths = possibleTiles.map { possibleTile -> [[Tile]] in
				var copy = route
				copy[route.count - 1].append(possibleTile)
				return copy
			}

			for possiblePath in possiblePaths {
				newPaths.append(possiblePath)
			}

		} else {
			// *add* new row below x = 0
			let bottomLeftMostTile = route.last![0] // rename to bottomLeftMostTile?

			let rotatedRemainingTiles = remainingTiles
				.flatMap { t in
					rotatedAndFlipped(t.matrix).map { m in
						Tile(id: t.id, matrix: m)
					}
				}

			let bottomEdge = bottomLeftMostTile.bottomEdge

			let possibleTiles = rotatedRemainingTiles.filter { remainingTile in
				return remainingTile.topEdge == bottomEdge
			}

			let possiblePaths = possibleTiles.map { possibleTile -> [[Tile]] in
				var copy = route
				copy.append([possibleTile])
				return copy
			}

			for possiblePath in possiblePaths {
					newPaths.append(possiblePath)
			}
		}

		return newPaths
	}
}

//2514 is too high (5 monsters, so there are more than 5 monsters.)
//2109 is too low (32 monsters, so there are fewer than 32 monsters.)
//2229 is too low (24 monsters, so there are fewer than 24 monsters.)
//2349 is not correct (16 monsters, so there are ???)
//2349 is not correct (16 monsters, so there are ???)
// 2589 - (15 * 15) / 2364 is not correct... ~5.5 minutes
