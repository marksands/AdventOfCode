import Foundation
import AdventOfCode

public final class Day15: Day {
	var gridOfInts: [[Int]] = []
	var grid: [Position: Int] = [:]

	var height: Int
	var width: Int
	var bottomCorner: Position
	var startingCost: Int
	
	// track the lowest found score for each position, as a means to prioritize
	// and prune branches if the score for this node is higher than our best case
	var scores: [Position: Int] = [:]

	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		for (y, line) in lines.enumerated() {
			var row: [Int] = []
			for (x, col) in line.exploded().enumerated() {
				row.append(Int(col)!)
				grid[Position(x: x, y: y)] = Int(col)!
			}
			gridOfInts.append(row)
		}
		
		height = gridOfInts.count - 1
		width = gridOfInts[0].count - 1
		bottomCorner = Position(x: width, y: height)
		startingCost = grid[Position(x: 0, y: 0)]!
		scores[Position(x: 0, y: 0)] = 0
	}

    public override func part1() -> String {
		var priorityQueue = PriorityQueue<[Position]>(sort: {
			(
				Day15.costOfPath($0, self.grid, self.startingCost),
				self.distanceToBottomRightCorner($0)
			) < (
				Day15.costOfPath($1, self.grid, self.startingCost),
				self.distanceToBottomRightCorner($1)
			)
			
//			(self.distanceToBottomRightCorner($0), $0.count, self.costOfPath($0)) <
//				(self.distanceToBottomRightCorner($1), $1.count, self.costOfPath($1))

//			(self.distanceToBottomRightCorner($0), $0.count + Day15.costOfPath($0, self.grid, self.startingCost)) <
//				(self.distanceToBottomRightCorner($1), $1.count + Day15.costOfPath($1, self.grid, self.startingCost))

			
//			(self.costOfPath($0) + self.distanceToBottomRightCorner($0)) < (self.costOfPath($1) + self.distanceToBottomRightCorner($1))
//			(self.costOfPath($0), self.distanceToBottomRightCorner($0)) < (self.costOfPath($1), self.distanceToBottomRightCorner($1))
		})

		priorityQueue.enqueue([Position(x: 0, y: 0)])

		while let top = priorityQueue.dequeue() {
			if top.last! == bottomCorner {
				// 455, 454, 452, 451, 450, 449, 448, 447, 446, 445, 444
//				if scores[bottomCorner, default: 999] < 444 { // have not checked 444, probably higher than 434, trying 440, 442, 443
					// ensure path has ascending cost
//					if top.eachPair().map({ scores[$1, default: Int.max] > scores[$0, default: Int.max] }).allSatisfy ({ $0 }) {
						printScores()
						return Day15.costOfPath(top, grid, startingCost).string
//					}
//				}
			}
			else {
				for potentialPath in pathNeighbors(of: top) {
					priorityQueue.enqueue(potentialPath)
				}
			}
		}

        return ":("
    }

    public override func part2() -> String {
		return ":("
    }

	@inline(__always)
	private static func costOfPath(_ path: [Position], _ grid: [Position: Int], _ startingCost: Int) -> Int {
		return path.reduce(into: 0, { $0 += grid[$1]! }) - startingCost
	}

	@inline(__always)
	private func distanceToBottomRightCorner(_ path: [Position]) -> Int {
		return path.last!.manhattanDistance(to: bottomCorner)
	}

	@inline(__always)
	private func pathNeighbors(of path: [Position]) -> [[Position]] {
		guard Day15.costOfPath(path, grid, startingCost) < 452 else { return [] }
		
		var neighbors: [[Position]] = []
		
		let cur = path.last!
		
		func isWithinRange(_ pos: Position) -> Bool {
			return pos.x >= 0 && pos.x <= width && pos.y >= 0 && pos.y <= height
		}
		
		let south = cur.south()
		if isWithinRange(south) && !path.contains(south) {
			let cost = Day15.costOfPath(path + [south], grid, startingCost)
			scores[south] = min(scores[south, default: Int.max], cost)
			if cost < scores[south]! {
				neighbors.append(path + [south])
			}
		}
		
		let east = cur.east()
		if isWithinRange(east) && !path.contains(east) {
			let cost = Day15.costOfPath(path + [east], grid, startingCost)
			scores[east] = min(scores[east, default: Int.max], cost)
			if cost < scores[east]! {
				neighbors.append(path + [east])
			}
		}
		
		let west = cur.west()
		if isWithinRange(west) && !path.contains(west) {
			let cost = Day15.costOfPath(path + [west], grid, startingCost)
			scores[west] = min(scores[west, default: Int.max], cost)
			if cost < scores[west]! {
				neighbors.append(path + [west])
			}
		}

		let north = cur.north()
		if isWithinRange(north) && !path.contains(north) {
			let cost = Day15.costOfPath(path + [north], grid, startingCost)
			scores[north] = min(scores[north, default: Int.max], cost)
			if cost < scores[north]! {
				neighbors.append(path + [north])
			}
		}

		return neighbors
	}
	
	func printScores() {
		var string = "SCORES: \n"
		for (y, row) in gridOfInts.enumerated() {
			for (x, col) in row.enumerated() {
				if let s = scores[Position(x: x, y: y)] {
					let pad = 3 - String(s).count
					let padStr = String(repeating: "0", count: pad)
					string += "[\(padStr + String(s))]"
				} else {
					string += "[?\(col)?]"
				}
			}
			string += "\n"
		}
		print(string)
	}
}
