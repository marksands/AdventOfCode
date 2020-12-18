import Foundation
import AdventOfCode

public final class Day18: Day {
	private var input: String

	public init(input: String = Input().trimmedRawInput()) {
		self.input = input
		super.init()
	}

	public override func part1() -> String {
		return shuntingYard()
	}

	public override func part2() -> String {
		return shuntingYard(part2: true)
	}

	private func shuntingYard(part2: Bool = false) -> String {
		var nums: [Int] = []

		for line in input.lines {
			var stack: [Character] = []
			var tokens: [Character] = []

			for character in line {
				if character.isNumber {
					tokens.append(character)
				} else if character == "(" {
					stack.append("(")
				} else if character == ")" {
					while !stack.isEmpty && stack.last! != "(" {
						tokens.append(stack.removeLast())
					}
					_ = stack.popLast()
				} else if symbols.contains(character) {
					rotateOperatorPrecedence(character, stack: &stack, tokens: &tokens, part2: part2)
					stack.append(character)
				}
			}

			while (!stack.isEmpty) {
				tokens.append(stack.removeLast());
			}

			let result = calculate(tokens)
			nums.append(result)
		}

		return String(nums.sum())
	}

	private func calculate(_ tokens: [Character]) -> Int {
		var tokenStack: [String] = []

		for state in tokens {
			if !symbols.contains(state) {
				tokenStack.append(String(state))
			} else {
				let state1 = Int(tokenStack.removeLast())!
				let state2 = Int(tokenStack.removeLast())!
				let result = state == "+" ? state1 + state2 : state1 * state2
				tokenStack.append(String(result))
			}
		}

		let value = Int(tokenStack.removeLast())!

		return value
	}

	private func rotateOperatorPrecedence(_ op: Character, stack: inout [Character], tokens: inout [Character], part2: Bool = false) {
		let comparison: [Character: Int] = ["+": part2 ? 2 : 1, "*": 1]
		while !stack.isEmpty && symbols.contains(stack.last!) && ((comparison[op]! - comparison[stack.last!]!) <= 0) {
			tokens.append(stack.removeLast())
		}
	}

	private var symbols: [Character] {
		return ["+", "*"]
	}
}
