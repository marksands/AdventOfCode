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
	
	func mostCommonElementExceptEmptyStringLol() -> Element {
		var dictionary: [Element: Int] = [:]
		for value in self {
			if value as? String == "" { continue }
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
	
	func leastCommonElementExceptEmptyStringLol() -> Element {
		var dictionary: [Element: Int] = [:]
		for value in self {
			if value as? String == "" { continue }
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
		let width = lines[0].count

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
		let width = 12 // lines[0].count maybe?

		var bits: [[String]] = Array(repeating: [String](), count: width)

		for line in lines {
			let nums = line.exploded()
			for i in (0..<width) {
				bits[i].append(nums[i])
			}
		}
		
		var i = 0
		var bitsCopy = bits
		var oxygenGenerator: String = ""
		
		while true {
			var mostCommonBitAtIndex = bitsCopy[i].mostCommonElementExceptEmptyStringLol()
			if bitsCopy[i].count(where: { $0 == "0" }) == bitsCopy[i].count(where: { $0 == "1" }) {
				mostCommonBitAtIndex = "1"
			}

			let indexesToBeCleared = bitsCopy[i].enumerated().filter { $0.1 == mostCommonBitAtIndex }
			
			for index in indexesToBeCleared.reversed() {
				for bitsCopyIndex in bitsCopy.indices {
					bitsCopy[bitsCopyIndex][index.offset] = ""
				}
			}
			
			if bitsCopy.allSatisfy({ row in row.filter { $0 != "" }.count == 1 }) {
				(0..<width).forEach { idx in
					oxygenGenerator.append(bitsCopy[idx].leastCommonElement())
				}
				break
			}
						
			i += 1
		}


		i = 0
		bitsCopy = bits
		var c02Scrubber: String = ""
		
		while true {
			var leastCommonBitAtIndex = bitsCopy[i].leastCommonElementExceptEmptyStringLol()
			if bitsCopy[i].count(where: { $0 == "0" }) == bitsCopy[i].count(where: { $0 == "1" }) {
				leastCommonBitAtIndex = "0"
			}
			
			let indexesToBeCleared = bitsCopy[i].enumerated().filter { $0.1 == leastCommonBitAtIndex }
			
			for index in indexesToBeCleared.reversed() {
				for bitsCopyIndex in bitsCopy.indices {
					bitsCopy[bitsCopyIndex][index.offset] = ""
				}
			}
			
			if bitsCopy.allSatisfy({ row in row.filter { $0 != "" }.count == 1 }) {
				(0..<width).forEach { idx in
					c02Scrubber.append(bitsCopy[idx].leastCommonElement())
				}
				break
			}
						
			i += 1
		}

		let o2 = Int(oxygenGenerator, radix: 2)!
		let c02 = Int(c02Scrubber, radix: 2)!

		return String(o2 * c02)
    }
}
