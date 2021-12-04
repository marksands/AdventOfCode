import Foundation
import AdventOfCode

public final class Day4: Day {
	private typealias Board = [[Int]]
	private var boards: [Board] = []
	private var orderOfDrawnNumbers: [Int] = []
	private let lines: [String]
	
	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.lines = lines
		super.init()

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
	
	public override func part1() -> String {
		for index in (orderOfDrawnNumbers.startIndex..<orderOfDrawnNumbers.endIndex) {
			for board in boards {
				if boardHasBingo(board, drawn: orderOfDrawnNumbers[0..<index]) {
					return score(of: board, drawn: orderOfDrawnNumbers[0..<index]).string
				}
			}
		}

		return ":("
	}

    public override func part2() -> String {
		let totalBoards = boards.count
		var wonBoardIndices: [Int] = []
		
		for index in (orderOfDrawnNumbers.startIndex..<orderOfDrawnNumbers.endIndex) {
			for (idx, board) in boards.enumerated() {
				if !wonBoardIndices.contains(idx), boardHasBingo(board, drawn: orderOfDrawnNumbers[0..<index]) {
					wonBoardIndices.append(idx)
					if wonBoardIndices.count == totalBoards {
						return score(of: board, drawn: orderOfDrawnNumbers[0..<index]).string
					}
				}
			}
		}

		return ":("
    }
		
	private func boardHasBingo(_ board: Board, drawn: ArraySlice<Int>) -> Bool {
		return board
			.anySatisfy({ $0.isContainedWithin(drawn) }) ||
		board.enumerated().map({ (y, col) in col.enumerated().map({ board[$0.offset][y] }) })
			.anySatisfy({ $0.isContainedWithin(drawn) })
	}
	
	private func score(of board: Board, drawn: ArraySlice<Int>) -> Int {
		return board.flatMap { $0 }.filter { !drawn.contains($0) }.sum() * drawn.last!
	}
}
