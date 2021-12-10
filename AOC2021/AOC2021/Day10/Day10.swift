import Foundation
import AdventOfCode

public final class Day10: Day {
	let lines: [String]
	
	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		self.lines = lines
	}
	
    public override func part1() -> String {
		return calculateScores().part1
	}

    public override func part2() -> String {
		return calculateScores().part2
	}
	
	private func calculateScores() -> (part1: String, part2: String) {
		let characters_open = ["(", "[", "{", "<"]
		let characters_closing: [String: String] = ["(": ")", "[": "]", "{": "}", "<": ">"]
		let character_closing_scores = [")": 3, "]": 57, "}": 1197, ">": 25137]
		let character_closing_scores_incomplete = [")": 1, "]": 2, "}": 3, ">": 4]
		
		var incompleteScores: [Int] = []
		var corruptedScore = 0
		for line in lines {
			var wasCorrupted = false
			var stack: [String] = []
			for character in line.exploded() {
				if characters_open.contains(character) {
					stack.append(character)
				} else if !stack.isEmpty {
					let top = stack.last!
					if characters_closing[top] == character {
						stack.removeLast()
					} else {
						// Encountered a corrupted line
						corruptedScore += character_closing_scores[character]!
						wasCorrupted = true
						break
					}
				}
			}
			if !stack.isEmpty, !wasCorrupted {
				// Encountered an incomplete line
				var score = 0
				while !stack.isEmpty {
					let top = stack.removeLast()
					let characterScore = character_closing_scores_incomplete[characters_closing[top]!]!
					score = (score * 5) + characterScore
				}
				incompleteScores.append(score)
			}
		}
		
		let sorted = incompleteScores.sorted()
		return (corruptedScore.string, sorted[sorted.count / 2].string)
    }
}
