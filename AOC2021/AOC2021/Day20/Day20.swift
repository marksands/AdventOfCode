import Foundation
import AdventOfCode

public final class Day20: Day {
	var imageEnhancementAlgorithm: [String]
	var inputImage: String
	
	public init(input: String = Input().trimmedRawInput()) {
		imageEnhancementAlgorithm = input.groups[0].exploded()
		inputImage = input.groups[1]
	}
	
	public override func part1() -> String {
		return run(steps: 2)
	}
	
	public override func part2() -> String {
		return run(steps: 50)
	}
	
	private func run(steps: Int) -> String {
		var image: [Position: String] = [:]
		
		for (y, line) in inputImage.lines.enumerated() {
			for (x, character) in line.exploded().enumerated() {
				image[Position(x: x, y: y)] = character
			}
		}
		
		borderOfPoints(arround: image, dimension: 50).forEach {
			image[$0] = "."
		}
		
		for iteration in (1...steps) {
			var copy: [Position: String] = [:]
			
			let minX = image.keys.map { $0.x }.min()!
			let maxX = image.keys.map { $0.x }.max()!
			let minY = image.keys.map { $0.y }.min()!
			let maxY = image.keys.map { $0.y }.max()!
			
			for y in (minY...maxY) {
				for x in (minX...maxX) {
					let position = Position(x: x, y: y)
					let nineByNine = position.surroundingIncludingSelf()
						.map { position -> String in
							let withinRange = position.x >= minX && position.x <= maxX &&
							  position.y >= minY && position.y <= maxY
							
							if withinRange {
								return image[position]!
							} else {
								return iteration % 2 == 0 ? "#" : "."
							}
						}
					
					let decimal = pixelStringToDecimal(nineByNine.joined())
					let replacementCharacter = imageEnhancementAlgorithm[decimal]

					copy[position] = replacementCharacter
				}
			}
			
			image = copy
		}
		
		return image.values.lazy.filter { $0 == "#" }.count.string
	}
	
	private func pixelStringToDecimal(_ string: String) -> Int {
		let binaryString = string
			.replacingOccurrences(of: ".", with: "0")
			.replacingOccurrences(of: "#", with: "1")
		return Int(binaryString, radix: 2)!
	}
}
