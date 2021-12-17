import Foundation
import AdventOfCode

public final class Day13: Day {
	var input: String
	var positions: [Position: String] = [:]
	var foldDirections: [Position] = []

	public init(input: String = Input().trimmedRawInput()) {
		self.input = input
				
		let inputComponents = input.groups
		for line in inputComponents[0].lines {
			let ints = String(line).ints
			positions[Position(x: ints[0], y: ints[1])] = "#"
		}
				
		for fold in inputComponents[1].lines {
			let line = String(fold).replacingOccurrences(of: "fold along ", with: "")
			if line.hasPrefix("x") {
				foldDirections.append(Position(x: line.int, y: 0))
			}
			else if line.hasPrefix("y") {
				foldDirections.append(Position(x: 0, y: line.int))
			}
		}
	}

    public override func part1() -> String {
		let firstFold = foldDirections[0]
		fold(firstFold)
		return printGrid().string
	}
	
	public override func part2() -> String {
		for foldDirection in foldDirections {
			fold(foldDirection)
		}
		return printGrid().string
	}
	
	private func fold(_ foldDirection: Position) {
		if foldDirection.x == 0 {
			// fold-y
			let foldedPositions: [Position] = Array(positions.keys.filter { $0.y > foldDirection.y })
			
			for position in foldedPositions {
				positions[position] = nil
				positions[Position(x: position.x, y: position.y - 2 * (position.y - foldDirection.y))] = "#"
			}
		} else {
			// fold-x
			let foldedPositions: [Position] = Array(positions.keys.filter { $0.x > foldDirection.x })
			
			for position in foldedPositions {
				positions[position] = nil
				positions[Position(x: position.x - 2 * (position.x - foldDirection.x), y: position.y)] = "#"
			}
		}
	}
	
	@discardableResult
	func printGrid() -> Int {
		var dotCount = 0
		let maxHeight = positions.filter { $0.value == "#" }.max(by: { $0.key.y < $1.key.y })!.key.y
		let maxWidth = positions.filter { $0.value == "#" }.max(by: { $0.key.x < $1.key.x })!.key.x
		
		for y in (0...maxHeight) {
			var string = ""
			for x in (0...maxWidth) {
				let value = positions[Position(x: x, y: y), default: "."]
				if value == "#" { dotCount += 1 }
				string += value
			}
			print(string)
		}
		
		return dotCount
	}
}
