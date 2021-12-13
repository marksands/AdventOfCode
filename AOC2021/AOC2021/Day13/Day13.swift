import Foundation
import AdventOfCode

public final class Day13: Day {
	var input: String
	var positions: [Position: String] = [:]
	var foldDirections: [Position] = []
	var maxWidth: Int
	var maxHeight: Int

	public init(input: String = Input().trimmedRawInput()) {
		self.input = input
				
		let inputComponents = input.components(separatedBy: "\n\n")
		for line in inputComponents[0].components(separatedBy: "\n") {
			let ints = String(line).ints
			positions[Position(x: ints[0], y: ints[1])] = "#"
		}
				
		for fold in inputComponents[1].components(separatedBy: "\n") {
			let line = String(fold).replacingOccurrences(of: "fold along ", with: "")
			if line.hasPrefix("x") {
				foldDirections.append(Position(x: line.int, y: 0))
			}
			else if line.hasPrefix("y") {
				foldDirections.append(Position(x: 0, y: line.int))
			}
		}
		
		maxWidth = positions.keys.map { $0.x }.max()!
		maxHeight = positions.keys.map { $0.y }.max()!
	}

    public override func part1() -> String {
		let firstFold = foldDirections[0]
		fold(firstFold)
		
		print("")
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
			let foldedPositions: [Position] = Array(positions.keys.filter { $0.y >= foldDirection.y })
			
			for position in foldedPositions {
				positions[position] = nil
				positions[Position(x: position.x, y: maxHeight - position.y)] = "#"
			}
			
			maxHeight = foldDirection.y - 1
		} else {
			// fold-x
			let foldedPositions: [Position] = Array(positions.keys.filter { $0.x >= foldDirection.x })
			
			for position in foldedPositions {
				positions[position] = nil
				positions[Position(x: maxWidth - position.x, y: position.y)] = "#"
			}
			
			maxWidth = foldDirection.x - 1
		}
	}
	
	@discardableResult
	func printGrid() -> Int {
		var dotCount = 0
		
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
