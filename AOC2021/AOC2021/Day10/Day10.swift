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
		let open = ["(", "[", "{", "<"]
		let closing = ["(": ")", "[": "]", "{": "}", "<": ">"]
		let closing_scores_corrupted = [")": 3, "]": 57, "}": 1197, ">": 25137]
		let closing_scores_incomplete = [")": 1, "]": 2, "}": 3, ">": 4]
		
		var incompleteScores: [Int] = []
		var corruptedScore = 0
		
		outer: for line in lines {
			var stack: [String] = []
			for character in line.exploded() {
				if open.contains(character) {
					stack.append(character)
				} else if let top = stack.last {
					if closing[top] == character {
						stack.removeLast()
					} else {
						corruptedScore += closing_scores_corrupted[character]!
						continue outer
					}
				}
			}
			
			if !stack.isEmpty {
				incompleteScores += [stack.reversed().reduce(0) { $0 * 5 + closing_scores_incomplete[closing[$1]!]! }]
			}
		}
		
		let sorted = incompleteScores.sorted()
		return (corruptedScore.string, sorted[sorted.count / 2].string)
    }
}
