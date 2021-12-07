import Foundation
import AdventOfCode

public final class Day7: Day {
	let ints: [Int]
	
	public init(lines: String = Input().trimmedRawInput()) {
		self.ints = lines.ints
	}
	
	public override func part1() -> String {
		var min = Int.max
		for value in ints {
			var sum = 0
			for value2 in ints {
				sum += abs(value2 - value)
			}
			min = Swift.min(sum, min)
		}
		return min.string
	}
	
	public override func part2() -> String {
		let maxNumber = ints.max()!
		var min = Int.max
		for value in (1..<maxNumber) {
			var sum = 0
			for value2 in ints {
				let distance = triangluarNumber(abs(value - value2))
				sum += distance
			}
			min = Swift.min(sum, min)
		}
		
		return min.string
	}
	
	func triangluarNumber(_ v: Int) -> Int {
		return (v * (v + 1))/2
	}
}
