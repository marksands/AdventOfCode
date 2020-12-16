import Foundation
import AdventOfCode

public final class Day14: Day {
	private var input: [String] = []

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		super.init()
		self.input = input
	}

	public override func part1() -> String {
		var memory: [Int: Int] = [:]
		var or_mask = 0
		var and_mask = 0

		for line in input {
			if line.hasPrefix("mask") {
				or_mask = maskToBinary(String(line.dropFirst(7)), replacing: "X", with: "0")
				and_mask = maskToBinary(String(line.dropFirst(7)), replacing: "X", with: "1")
			} else {
				let offsetToValue = line.dropFirst(4).components(separatedBy: "] = ")
				let (offset, value) = (Int(offsetToValue[0])!, Int(offsetToValue[1])!)
				memory[offset] = (value | or_mask) & and_mask
			}
		}

		return String(memory.values.sum())
	}

	public override func part2() -> String {
		var memory: [String: Int] = [:]
		var currentMask = ""

		for line in input {
			if line.hasPrefix("mask") {
				currentMask = String(line.dropFirst(7))
			} else {
				let offsetToValue = line.dropFirst(4).components(separatedBy: "] = ")
				let (offset, value) = (Int(offsetToValue[0])!, Int(offsetToValue[1])!)
				let offsetAsBinaryString = intTo36BitBinaryString(offset)

				let offsets = generateOffsets(offsetAsBinaryString, mask: currentMask, startingAtIndex: 35)
				for decodedOffset in offsets {
					memory[decodedOffset] = value
				}
			}
		}

		return String(memory.values.sum())
	}

	func generateOffsets(_ offset: String, mask: String, startingAtIndex index: Int) -> [String] {
		guard index >= 0 else { return [offset] }

		if mask[unsafe: index] == "0" {
			return generateOffsets(offset, mask: mask, startingAtIndex: index - 1)
		} else if mask[unsafe: index] == "1" {
			return generateOffsets(replace(string: offset, at: index, with: "1"), mask: mask, startingAtIndex: index - 1)
		} else if mask[unsafe: index] == "X" {
			return generateOffsets(replace(string: offset, at: index, with: "1"), mask: mask, startingAtIndex: index - 1) +
				generateOffsets(replace(string: offset, at: index, with: "0"), mask: mask, startingAtIndex: index - 1)
		} else {
			fatalError()
		}
	}

	func maskToBinary(_ value: String, replacing: String, with char: String) -> Int {
		Int(value.replacingOccurrences(of: replacing, with: char), radix: 2)!
	}

	func valueToBinaryString(_ int: Int) -> String {
		return String(int, radix: 2, uppercase: false)
	}

	func intTo36BitBinaryString(_ value: Int) -> String {
		let bin = String(value, radix: 2, uppercase: false)
		return Array(repeating: "0", count: 36 - bin.count).joined() + bin
	}

	func replace(string: String, at index: Int, with char: Character) -> String {
		var chars = Array(string)
		chars[index] = char
		return String(chars)
	}
}
