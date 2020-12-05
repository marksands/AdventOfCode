import Foundation
import AdventOfCode

public final class Day5: Day {
	var lines: [String] = []

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.lines = input
		super.init()
	}

	public override func part1() -> String {
		let id = lines.map { seatId($0) }.max(by: <)!
		return String(id)
	}

	public override func part2() -> String {
		let allIds = lines.map { self.seatId($0) }
		let seatId = allIds.first(where: { !allIds.contains($0+1) && allIds.contains($0+2) })! + 1
		return String(seatId)
	}

	func seatId(_ string: String) -> Int {
		return Int(string.map { $0 == "B" ? "1" : $0 == "R" ? "1" : "0" }.joined(), radix: 2)!
	}
}
