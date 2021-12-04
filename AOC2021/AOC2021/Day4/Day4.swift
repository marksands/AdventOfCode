import Foundation
import AdventOfCode

public final class Day4: Day {
	typealias Board = [[Int]]
	var boards: [Board] = []
	var orderOfDrawnNumbers: [Int] = []
	
	let lines: [String]
	
	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.lines = lines
		super.init()
		parseInput()
	}
	
	public override func part1() -> String {
		var rollCall: [Int] = []
		for drawn in orderOfDrawnNumbers {
			rollCall.append(drawn)
			for board in boards {
				if boardHasBingo(board, drawn: rollCall) {
					return String(score(of: board, drawn: rollCall))
				}
			}
		}

		return ":("
	}

    public override func part2() -> String {
		let totalBoards = boards.count
		var wonBoardIndices: [Int] = []
		
		var rollCall: [Int] = []
		for drawn in orderOfDrawnNumbers {
			rollCall.append(drawn)
			for (idx, board) in boards.enumerated() {
				if boardHasBingo(board, drawn: rollCall), !wonBoardIndices.contains(idx) {
					wonBoardIndices.append(idx)
					if wonBoardIndices.count == totalBoards {
						return String(score(of: board, drawn: rollCall))
					}
				}
			}
		}

		return ":("
    }
	
	private func parseInput() {
		var lines = self.lines
		let drawnOrderLine = lines.removeFirst()
		orderOfDrawnNumbers = drawnOrderLine.ints
		
		var currentBoard: Board = []
		for line in lines.dropFirst() {
			if line == "" {
				boards.append(currentBoard)
				currentBoard = []
			} else {
				currentBoard.append(line.ints)
			}
		}
		boards.append(currentBoard)
	}
	
	private func boardHasBingo(_ board: Board, drawn: [Int]) -> Bool {
		for row in board {
			if row.isContainedWithin(drawn) { return true }
		}
		
		for (y, col) in board.enumerated() {
			let column = col.enumerated().map { board[$0.offset][y] }
			if column.isContainedWithin(drawn) { return true }
		}
		
		return false
	}
	
	private func score(of board: Board, drawn: [Int]) -> Int {
		let allNumbers = board.flatMap { $0 }
		let unmarkedNumbers = allNumbers.filter { !drawn.contains($0) }
		return unmarkedNumbers.sum() * drawn.last!
	}
}
