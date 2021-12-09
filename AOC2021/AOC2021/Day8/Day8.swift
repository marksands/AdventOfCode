import Foundation
import AdventOfCode

public final class Day8: Day {
	let lines: [String]
	
	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.lines = lines
	}

    public override func part1() -> String {
		var count = 0
		let lengthsOf1478 = [2, 4, 3, 7]
		
		for line in lines {
			let output = line.components(separatedBy: " | ")[1]
			let eachSignalOutput = output.components(separatedBy: " ")
			
			for o in eachSignalOutput {
				for length in lengthsOf1478 {
					if o.count == length {
						count += 1
					}
				}
			}
		}
		
		return count.string
    }

    public override func part2() -> String {
		var numbers: [Int] = []
		
		for line in lines {
			let output = line.components(separatedBy: " | ")[1]
			let eachSignalOutput = output.components(separatedBy: " ")
			let sortedOuput = eachSignalOutput.map { String($0.sorted()) }
			let eachSignalInput = line.components(separatedBy: " | ")[0].components(separatedBy: " ")
			let result = bruteForceDigits(sortedOuput, validating: eachSignalInput)
			numbers += [result]
//			print("\(eachSignalOutput.joined(separator: " ")): \(result)")
		}

		return numbers.sum().string
    }

	private func bruteForceDigits(_ output: [String], validating: [String]) -> Int {
		guard let result = "abcdefg".exploded().permutations().first(where: { permutedOrder in
			let mapping = Mapping(
				top: permutedOrder[0],
				topLeft: permutedOrder[1],
				topRight: permutedOrder[2],
				center: permutedOrder[3],
				bottomLeft: permutedOrder[4],
				bottomRight: permutedOrder[5],
				bottom: permutedOrder[6]
			)

			let isValidMappingPermuation = output.compactMap({ characters -> AsciiInt? in
				let possibleInt = mapping.possibleAsciiInt(from: characters.exploded())
				if let number = possibleInt {
					if number.intValue == 1 { return characters.count == 2 ? number : nil }
					else if number.intValue == 4 { return characters.count == 4 ? number : nil }
					else if number.intValue == 7 { return characters.count == 3 ? number : nil }
					else if number.intValue == 8 { return characters.count == 7 ? number : nil }
					// non-unique lengths
					else if number.intValue == 2 { return characters.count == 5 ? number : nil }
					else if number.intValue == 3 { return characters.count == 5 ? number : nil }
					else if number.intValue == 5 { return characters.count == 5 ? number : nil }
					else if number.intValue == 6 { return characters.count == 6 ? number : nil }
					else if number.intValue == 9 { return characters.count == 6 ? number : nil }
					else if number.intValue == 0 { return characters.count == 6 ? number : nil }
					else {
						fatalError()
					}
				} else {
					return possibleInt
				}
			}).count == 4
			
			let isValidMappingForInput = validating.allSatisfy { mapping.possibleAsciiInt(from: $0.exploded()) != nil }
			return isValidMappingPermuation && isValidMappingForInput
		}) else {
			fatalError("Your brute force code is busted!")
		}
		
		let mapping = Mapping(top: result[0], topLeft: result[1],
						topRight: result[2], center: result[3],
						bottomLeft: result[4], bottomRight: result[5], bottom: result[6])
		
		let stringResult = output
			.compactMap({ mapping.possibleAsciiInt(from: $0.exploded()) })
			.map { String($0.intValue) }
			.joined()
		
		return Int(stringResult)!
	}
}

struct Mapping {
	var top: String
	var topLeft: String
	var topRight: String
	var center: String
	var bottomLeft: String
	var bottomRight: String
	var bottom: String
	
	init(top: String, topLeft: String, topRight: String, center: String, bottomLeft: String, bottomRight: String, bottom: String) {
		self.top = top
		self.topLeft = topLeft
		self.topRight = topRight
		self.center = center
		self.bottomLeft = bottomLeft
		self.bottomRight = bottomRight
		self.bottom = bottom
	}
	
	func possibleAsciiInt(from characters: [String]) -> AsciiInt? {
		var top: String?
		var topLeft: String?
		var topRight: String?
		var center: String?
		var bottomLeft: String?
		var bottomRight: String?
		var bottom: String?
		
		for character in characters {
			if character == self.top { top = self.top }
			else if character == self.topLeft { topLeft = self.topLeft }
			else if character == self.topRight { topRight = self.topRight }
			else if character == self.center { center = self.center }
			else if character == self.bottomLeft { bottomLeft = self.bottomLeft }
			else if character == self.bottomRight { bottomRight = self.bottomRight }
			else if character == self.bottom { bottom = self.bottom }
		}
		
		return AsciiInt(top: top,
						topLeft: topLeft,
						topRight: topRight,
						center: center,
						bottomLeft: bottomLeft,
						bottomRight: bottomRight,
						bottom: bottom)
	}
}

struct AsciiInt {
	var top: String?
	var topLeft: String?
	var topRight: String?
	var center: String?
	var bottomLeft: String?
	var bottomRight: String?
	var bottom: String?
	
	var intValue: Int
	
	init?(
		top: String? = nil, topLeft: String? = nil, topRight: String? = nil,
		center: String? = nil,
		bottomLeft: String? = nil, bottomRight: String? = nil,
		bottom: String? = nil
	) {
		self.top = top
		self.topLeft = topLeft
		self.topRight = topRight
		self.center = center
		self.bottomLeft = bottomLeft
		self.bottomRight = bottomRight
		self.bottom = bottom
		
		func valuesArePresent(_ values: [String?]) -> Bool {
			let filtered = values.compactMap { $0 }
			return filtered.count == values.count
		}
		
		func valuesMissing(_ values: [String?]) -> Bool {
			return values.count > 0 && values.allSatisfy { $0 == nil }
		}
				
		if valuesArePresent([top, topLeft, topRight, bottomLeft, bottomRight, bottom]), valuesMissing([center]) {
			self.intValue = 0
		} else if valuesArePresent([topRight, bottomRight]), valuesMissing([top, topLeft, center, bottomLeft, bottom]) {
			self.intValue = 1
		} else if valuesArePresent([top, center, bottom, topRight, bottomLeft]), valuesMissing([topLeft, bottomRight]) {
			self.intValue = 2
		} else if valuesArePresent([top, center, bottom, topRight, bottomRight]), valuesMissing([topLeft, bottomLeft]) {
			self.intValue = 3
		} else if valuesArePresent([topLeft, topRight, center, bottomRight]), valuesMissing([top, bottomLeft, bottom]) {
			self.intValue = 4
		} else if valuesArePresent([top, center, bottom, topLeft, bottomRight]), valuesMissing([topRight, bottomLeft]) {
			self.intValue = 5
		} else if valuesArePresent([top, center, bottom, topLeft, bottomLeft, bottomRight]), valuesMissing([topRight]) {
			self.intValue = 6
		} else if valuesArePresent([top, topRight, bottomRight]), valuesMissing([topLeft, center, bottomLeft, bottom]) {
			self.intValue = 7
		} else if valuesArePresent([top, center, bottom, topLeft, topRight, bottomLeft, bottomRight]) {
			self.intValue = 8
		} else if valuesArePresent([top, center, bottom, topLeft, topRight, bottomRight]), valuesMissing([bottomLeft]) {
			self.intValue = 9
		} else {
			return nil
		}
	}
}
