import Foundation
import AdventOfCode
import AOC2015

public final class Day16: Day {
	class Packet {
		let version: Int
		let type: Int
		
		init(version: Int, type: Int) {
			self.version = version
			self.type = type
		}
		
		func versions() -> [Int] {
			return [version]
		}
		
		func value() -> Int {
			fatalError("Implement me!")
		}
	}
	
	class LiteralPacket: Packet {
		let literal: Int
		
		init(version: Int, type: Int, literal: Int) {
			self.literal = literal
			super.init(version: version, type: type)
		}
		
		override func value() -> Int {
			return literal
		}
	}
	
	class OperatorPacket: Packet {
		var subPackets: [Packet]
		
		init(version: Int, type: Int, subPackets: [Packet]) {
			self.subPackets = subPackets
			super.init(version: version, type: type)
		}
		
		override func versions() -> [Int] {
			return [version] + subPackets.reduce([], { $0 + $1.versions() })
		}
		
		override func value() -> Int {
			if type == 0 {
				return subPackets.reduce(0, { $0 + $1.value() })
			} else if type == 1 {
				return subPackets.reduce(1, { $0 * $1.value() })
			} else if type == 2 {
				return subPackets.reduce(Int.max, { min($0, $1.value()) })
			} else if type == 3 {
				return subPackets.reduce(Int.min, { max($0, $1.value()) })
			} else if type == 5 {
				return subPackets[0].value() > subPackets[1].value() ? 1 : 0
			} else if type == 6 {
				return subPackets[0].value() < subPackets[1].value() ? 1 : 0
			} else if type == 7 {
				return subPackets[0].value() == subPackets[1].value() ? 1 : 0
			} else {
				fatalError()
			}
		}
	}
	
	private let input: String
	
	public init(input: String = Input().trimmedRawInput()) {
		self.input = input
	}
	
	public override func part1() -> String {
		let binaryForm = input.exploded().reduce(into: "") { $0 += String(Int($1, radix: 16)!, radix: 2).leftPad() }
		//		print("binary:", binaryForm)
		
		let result = binaryForm.exploded()
		let versionSum = parse(result)
			.output
			.reduce(0) { $0 + $1.versions().sum() }
		return versionSum.string
	}
	
	public override func part2() -> String {
		let binaryForm = input.exploded().reduce(into: "") { $0 += String(Int($1, radix: 16)!, radix: 2).leftPad() }
		//		print("binary:", binaryForm)
		
		let result = binaryForm.exploded()
		let packets = parse(result).output

		return packets[0].value().string
	}
	
	func parse(_ input: [String]) -> (input: [String], output: [Packet]) {
		guard input.count > 0 else { return ([], []) }

		if input.allSatisfy({ $0 == "0" }) { return ([], []) }
		
		var copy = input
		let version = Int(copy.popFirst(3).joined(), radix: 2)!
		let type = Int(copy.popFirst(3).joined(), radix: 2)!
		
		if type == 4 {
			var literalBinString = ""
			while let leadingBit = copy.popFirst(), leadingBit == "1" {
				literalBinString += String(copy.popFirst(4).joined())
			}
			literalBinString += String(copy.popFirst(4).joined())
			let literal = Int(literalBinString, radix: 2)!
			let packet = LiteralPacket(version: version, type: type, literal: literal)
			
			let (remaining, foundPackets) = parse(copy)
			return (remaining, [packet] + foundPackets)
		} else if copy.popFirst() == "0" {
			let bitLength = Int(copy.popFirst(15).joined(), radix: 2)!
			
			let subInput = Array(copy.popFirst(bitLength))
			
			let (remaining, foundPackets) = parse(subInput)
			assert(remaining == [])
			
			let packet = OperatorPacket(
				version: version,
				type: type,
				subPackets: foundPackets
			)
			
			let (remaining2, found2) = parse(copy)
			return (remaining2, [packet] + found2)
		} else  {
			let countOfPackets = Int(copy.popFirst(11).joined(), radix: 2)!
			
			let (trimmedInput, foundPackets) = parse(copy)
			
			let packet = OperatorPacket(
				version: version,
				type: type,
				subPackets: Array(foundPackets.prefix(countOfPackets))
			)
			
			return (trimmedInput, [packet] + foundPackets.dropFirst(countOfPackets))
		}
	}
}

extension String {
	func leftPad(length: Int = 4) -> String {
		if count < length {
			return String(repeating: "0", count: length - count) + self
		} else {
			return self
		}
	}
}
