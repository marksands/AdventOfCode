import Foundation
import AdventOfCode

public final class Day2: Day {
	struct Password {
		let low: Int
		let high: Int
		let letter: String
		let string: String
	}

	private let lines: [Password]

	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		let regex = Regex(pattern: "(\\d{1,2})\\-(\\d{1,2}) (\\w): (\\w+)")

		let passwords = lines.map { line -> Password in
			let matches = regex.allMatches(line)[0]
			return Password(low: Int(matches[1])!,
							high: Int(matches[2])!,
							letter: String(matches[3]),
							string: String(matches[4]))
		}

		self.lines = passwords

		super.init()
	}

	public override func part1() -> String {
		var validCount = 0

		for line in lines {
			let count = line.string.count(where: { String($0) == line.letter })
			if count >= line.low && count <= line.high {
				validCount += 1
			}
		}

		return String(validCount)
	}

	public override func part2() -> String {
		var validCount = 0

		for line in lines {
			let chars = line.string.exploded()
			if chars[safe: line.low - 1] == line.letter && chars[safe: line.high - 1] != line.letter{
				validCount += 1
			} else if chars[safe: line.low - 1] != line.letter && chars[safe: line.high - 1] == line.letter{
				validCount += 1
			}
		}

		return String(validCount)
	}
}
