import Foundation
import AdventOfCode

extension Collection where Element: Hashable {
	func mostCommonElement() -> Element {
		var dictionary: [Element: Int] = [:]
		for value in self {
			dictionary[value, default: 0] += 1
		}
		return dictionary.max { $0.value < $1.value }!.key
	}

	func leastCommonElement() -> Element {
		var dictionary: [Element: Int] = [:]
		for value in self {
			dictionary[value, default: 0] += 1
		}
		return dictionary.min { $0.value < $1.value }!.key
	}
}


public final class Day3: Day {
	private let lines: [String]

	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.lines = lines
		super.init()
	}

    public override func part1() -> String {
		let width = 12 // lines[0].count maybe?

		var bits: [[String]] = Array(repeating: [String](), count: width)

		for line in lines {
			let nums = line.exploded()
			for i in (0..<width) {
				bits[i].append(nums[i])
			}
		}
		
		let gammaBinary = bits.map { $0.mostCommonElement() }.joined()
		let epsilonBinary = bits.map { $0.leastCommonElement() }.joined()

		let gamma = Int(gammaBinary, radix: 2)!
		let epsilon = Int(epsilonBinary, radix: 2)!

		return String(gamma * epsilon)
    }

    public override func part2() -> String {
		return ""
    }
}
