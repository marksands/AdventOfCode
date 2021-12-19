import Foundation
import AdventOfCode

// TODO: maybe redo this entirely. This was a midnight grind with poor ideas albeit passing solutions.

extension NSRange {
	public init(_ range: Range<String.Index>) {
		self.init(location: range.lowerBound.encodedOffset,
				  length: range.upperBound.encodedOffset -
				  range.lowerBound.encodedOffset) }
}

public final class Day18: Day {
	private let lines: [String]
	
	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.lines = input
	}
	
    public override func part1() -> String {
		var sumResult = lines[0]
		
		for line in lines.dropFirst() {
			sumResult = addSnailfishToFormAPair(sumResult, line)
			
			var reducing = true
			while reducing {
				if let (si, ei) = maybeExplodingIndices(sumResult) {
					let pairs = explodingPairAtIndex(sumResult, (si, ei))
					sumResult = explode(sumResult, index: (si, ei), pair: pairs)
				} else if let match = hasSplittingCriteria(sumResult) {
					sumResult = split(sumResult, matching: match)
				} else {
					reducing = false
				}
				print(sumResult)
			}
		}
		
		print(sumResult)
		
		return magnitude(sumResult).string
    }

    public override func part2() -> String {
		var largestMag = Int.min
		
		lines.combinations(of: 2).forEach { lines in
			
			var s1 = addSnailfishToFormAPair(lines[0], lines[1])
			
			var reducing = true
			while reducing {
				if let (si, ei) = maybeExplodingIndices(s1) {
					let pairs = explodingPairAtIndex(s1, (si, ei))
					s1 = explode(s1, index: (si, ei), pair: pairs)
				} else if let match = hasSplittingCriteria(s1) {
					s1 = split(s1, matching: match)
				} else {
					reducing = false
				}
			}
			
			var s2 = addSnailfishToFormAPair(lines[1], lines[0])

			reducing = true
			while reducing {
				if let (si, ei) = maybeExplodingIndices(s2) {
					let pairs = explodingPairAtIndex(s2, (si, ei))
					s2 = explode(s2, index: (si, ei), pair: pairs)
				} else if let match = hasSplittingCriteria(s2) {
					s2 = split(s2, matching: match)
				} else {
					reducing = false
				}
			}

			largestMag = max(largestMag, magnitude(s1))
			largestMag = max(largestMag, magnitude(s2))
		}

		return largestMag.string
    }
	
	public func addSnailfishToFormAPair(_ line1: String, _ line2: String) -> String {
		return "[\(line1),\(line2)]"
	}
	
	public func split(_ line: String, matching: String) -> String {
		let firstRangeOfMatch = line.ranges(of: matching)[0]
		
		let int = Int(matching)!
		
		let leftNumber = Int(floor(Double(int) / 2.0))
		let rightNumber = Int(ceil(Double(int) / 2.0))
		
		var copy = line
		copy.replaceSubrange(firstRangeOfMatch, with: "[\(leftNumber),\(rightNumber)]")

		return copy
	}
	
	public func explode(_ line: String, index: (Int, Int), pair: (Int, Int)) -> String {
		var copy = line
		var additionalOffsetFromLeft = 0

		let leftOfExplosion = line.exploded()[0..<index.0].joined()
		let leftIntegerMatch = leftOfExplosion.ints.last

		if let match = leftIntegerMatch {
			let range = leftOfExplosion.ranges(of: String(match)).last!
			let result = String(pair.0 + match)
			additionalOffsetFromLeft = result.count - String(match).count
			copy.replaceSubrange(range, with: result)
		}

		let rightOfExplosion = copy.exploded()[(additionalOffsetFromLeft + index.1 + 1)...].joined()
		let rightIntegerMatch = rightOfExplosion.ints.first

		if let match = rightIntegerMatch {
			let range = rightOfExplosion.ranges(of: String(match)).first!
			var nsrange = NSRange(range)
			let result = String(pair.1 + match)
			nsrange.location = additionalOffsetFromLeft + index.1 + 1 + nsrange.location
			nsrange.length = String(match).count
			let replacingRange = Range<String.Index>(nsrange, in: copy)!
			copy.replaceSubrange(replacingRange, with: result)
		}

		// explode the pair step:
		let offsetStartIndex = index.0 + additionalOffsetFromLeft
		let offsetEndIndex = index.1 + additionalOffsetFromLeft
		let location = offsetStartIndex - 1
		let length = (offsetStartIndex...offsetEndIndex).count + 2
		let nsrange = NSMakeRange(location, length)
		let replacingRangeWithZero = Range<String.Index>(nsrange, in: copy)!
		copy.replaceSubrange(replacingRangeWithZero, with: "0")

		return copy
	}
	
	public func explodingPairAtIndex(_ line: String, _ index: (Int, Int)) -> (Int, Int) {
		let values = line.exploded()[index.0...index.1].joined().ints
		return (values[0], values[1])
	}
	
	public func maybeExplodingIndices(_ line: String) -> (Int, Int)? {
		var firstIndex: Int = -1
		var depth = 0
		for (idx, character) in line.enumerated() {
			if character == "[" {
				depth += 1
			} else if character == "]" {
				depth -= 1
			}
			
			if depth == 5 {
				firstIndex = idx
				let finalIndex = line.exploded()[firstIndex...].firstIndex(where: { $0 == "]" })!
				return (firstIndex + 1, finalIndex - 1)
			}
		}
		return nil
	}

	public func hasSplittingCriteria(_ line: String) -> String? {
		return line.ints.first(where: { $0 >= 10 }).map { String($0) }
	}
	
	public func magnitude(_ line: String) -> Int {
		if line.ints.count == 1 {
			return line.int
		} else {
			let strippedPairs = line.dropFirst().dropLast()

			var depth = 1
			var index = 0
			for character in strippedPairs {
				if character == "[" {
					depth += 1
				} else if character == "]" {
					depth -= 1
				}
				
				if depth == 1 {
					break
				}
				index += 1
			}
			
			let left = strippedPairs.exploded()[0...index].joined()
			let right = strippedPairs.exploded()[(index+2)...].joined()
			return 3 * magnitude(left) + 2 * magnitude(right)
		}
	}
}
