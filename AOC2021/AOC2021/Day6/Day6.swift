import Foundation
import AdventOfCode

public final class Day6: Day {
	let initialState: [Int]
	
	public init(line: String = Input().trimmedRawInput()) {
		self.initialState = line.ints
	}
	
    public override func part1() -> String {
		return step(iterations: 80).string
	}

    public override func part2() -> String {
		return step(iterations: 256).string
	}
	
	private func step(iterations: Int) -> Int {
		var dictionary: [Int: Int] = initialState.countElements()
		(0..<iterations).forEach { iteration in
			var copy: [Int: Int] = [:]
			for (key, value) in dictionary {
				if key == 0 {
					copy[6, default: 0] += value
					copy[8, default: 0] += value
				} else {
					copy[key - 1, default: 0] += value
				}
			}
			dictionary = copy
		}
		return dictionary.values.sum()
    }
}
