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

func flipped(_ matrix: [String]) -> [String] {
	var flipped: [String] = []
	for row in matrix {
		flipped.append(String(row.reversed()))
	}
	return flipped
}

func rotatedAndFlipped(_ matrix: [String]) -> [[String]] {
	let mutations = (0...3).flatMap { i -> [[String]] in
		let m = rotated(matrix, i)
		return [m, flipped(m)]
	}

	return mutations
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

		let allRotatedTiles = 	tiles
			.flatMap { t in
				rotatedAndFlipped(t.matrix).map { m in
					Tile(id: t.id, matrix: m)
				}
			 }

		for tile in allRotatedTiles {
			var queue = PriorityQueue<[[Tile]]>(sort: { $0.count > $1.count })
			queue.enqueue([[tile]])

			while queue.count > 0 {
				let path = queue.dequeue()!

				if path.flatMap({ $0 }).count == tiles.count { // max, found it
					possibleTilePositions.enqueue(path)
					break // maybe?? yes?
				}

				for possiblePath in possiblePaths(of: path) {
					queue.enqueue(possiblePath)
				}
			}
		}

		let found = possibleTilePositions.dequeue()!

		print(found)

		let result = found[0][0].id * found[11][0].id * found[11][11].id * found[0][11].id

		return "\(result)"
	}

	public override func part2() -> String {
		return ""
	}

	func possiblePaths(of route: [[Tile]]) -> [[[Tile]]] {
		let initialRouteTiles = route.flatMap { $0 }.map { $0.id }
		let remainingTiles = self.tiles.filter { !initialRouteTiles.contains($0.id) }

		// for tile in each row, check rightmost - look for edges touching east/west
		// for tile in each row, check bottommost - look for edges touching south/north

		var newPaths: [[[Tile]]] = []

		// let's start by producing a 1x12 row and then only looking downward?

		for (y, row) in route.enumerated() {
			for (x, tile) in row.enumerated() {
				if x == row.count-1, x < 12 { // right-most
					// check each tile

					let rotatedRemainingTiles = remainingTiles
						.flatMap { t in
							rotatedAndFlipped(t.matrix).map { m in
								Tile(id: t.id, matrix: m)
							}
						}

					let rightEdge = tile.rightEdge
					let possibleTiles = rotatedRemainingTiles.filter { remainingTile in
						return remainingTile.leftEdge == rightEdge
					}

					let possiblePaths = possibleTiles.map { possibleTile -> [[Tile]] in
						var copy = route
						copy[y].append(possibleTile)
						return copy
					}

					for possiblePath in possiblePaths {
						newPaths.append(possiblePath)
					}
				}

				if y == row.count-1, y < 12 { // bottom-most
					// check each tile

					let rotatedRemainingTiles = remainingTiles
						.flatMap { t in
							rotatedAndFlipped(t.matrix).map { m in
								Tile(id: t.id, matrix: m)
							}
						}

					let bottomEdge = tile.bottomEdge
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
			}
		}

		return newPaths
	}
}
