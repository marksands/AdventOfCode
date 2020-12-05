import Foundation
import AdventOfCode

public final class Day5: Day {
	var seatIds: [Int] = []

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		super.init()
		self.seatIds = input.map {
			Int($0.map { $0 == "B" ? "1" : $0 == "R" ? "1" : "0" }.joined(), radix: 2)!
		}
	}

	public override func part1() -> String {
		return String(seatIds.max(by: <)!)
	}

	public override func part2() -> String {
		return String(seatIds.first(where: { !seatIds.contains($0+1) && seatIds.contains($0+2) })! + 1)
	}
}
