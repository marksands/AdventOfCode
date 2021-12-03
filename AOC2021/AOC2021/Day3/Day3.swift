import Foundation
import AdventOfCode

public final class Day3: Day {
	private let bits: [[String]]

	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		let width = lines[0].count

		var bits: [[String]] = Array(repeating: [String](), count: width)

		for line in lines {
			let nums = line.exploded()
			for i in (0..<width) {
				bits[i].append(nums[i])
			}
		}
		
		self.bits = bits
		super.init()
	}

    public override func part1() -> String {
		let gammaBinary = bits.map { $0.mostCommonElement() }.joined()
		let epsilonBinary = bits.map { $0.leastCommonElement() }.joined()
		let gamma = Int(gammaBinary, radix: 2)!
		let epsilon = Int(epsilonBinary, radix: 2)!
		return String(gamma * epsilon)
    }

    public override func part2() -> String {
		func sensorRating(bits: [[String]], tieBeakerBit: String, bitCriteria: ([String]) -> String) -> String {
			var i = 0
			var bitsCopy = bits

			while true {
				var bitCriteriaMatchingBitAtIndex = bitCriteria(bitsCopy[i])
				
				// equal number of 0s and 1s
				if bitsCopy[i].countElements().values.unique().count == 1 {
					bitCriteriaMatchingBitAtIndex = tieBeakerBit
				}

				let indexesToBeCleared = bitsCopy[i].enumerated().filter { $0.1 == bitCriteriaMatchingBitAtIndex }
				
				for index in indexesToBeCleared.reversed() {
					for bitsCopyIndex in bitsCopy.indices {
						bitsCopy[bitsCopyIndex].remove(at: index.offset)
					}
				}
				
				if bitsCopy.map(\.count).allSatisfy({ $0 == 1 }) {
					return bitsCopy.flatMap { $0 }.joined()
				}

				i += 1
			}
			
			fatalError("Failed to prune bits!")
		}

		let oxygenGenerator = sensorRating(bits: bits, tieBeakerBit: "1", bitCriteria: { $0.mostCommonElement() })
		let c02Scrubber = sensorRating(bits: bits, tieBeakerBit: "0", bitCriteria: { $0.leastCommonElement() })

		let o2 = Int(oxygenGenerator, radix: 2)!
		let c02 = Int(c02Scrubber, radix: 2)!

		return String(o2 * c02)
    }
}
