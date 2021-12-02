import Foundation
import AdventOfCode

public final class Day2: Day {
	private let lines: [String]

	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.lines = lines
		super.init()
	}

	public override func part1() -> String {
		var horizontal = 0
		var depth = 0
		
		for line in lines {
			let value = line.ints[0]
			
			if line.starts(with: "forward") {
				horizontal += value
			} else if line.starts(with: "down") {
				depth += value
			} else {
				depth -= value
			}
		}
		
		return String(horizontal * depth)
	}
	
	public override func part2() -> String {
		var aim = 0
		var horizontal = 0
		var depth = 0
		
		for line in lines {
			let value = line.ints[0]

			if line.starts(with: "forward") {
				horizontal += value
				depth += (aim * value)
			} else if line.starts(with: "down") {
				aim += value
			} else {
				aim -= value
			}
		}
		
		return String(horizontal * depth)
    }
}
