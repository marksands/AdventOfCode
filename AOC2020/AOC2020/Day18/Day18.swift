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
			var stack: [String] = []
			var tokens: [String] = []

			for character in line {
				if character.isNumber {
					tokens.append(String(character))
				} else if character == "(" {
					stack.append("(")
				} else if character == ")" {
					while !stack.isEmpty && stack.last! != "(" {
						tokens.append(stack.removeLast())
					}
					_ = stack.popLast()
				} else if character == "+" {
					rotateOperatorPrecedence("+", stack: &stack, tokens: &tokens, plusWeight: part2 ? 2 : 1)
					stack.append("+")
				} else if character == "-" {
					rotateOperatorPrecedence("-", stack: &stack, tokens: &tokens, plusWeight: part2 ? 2 : 1)
					stack.append("-")
				} else if character == "*" {
					rotateOperatorPrecedence("*", stack: &stack, tokens: &tokens, plusWeight: part2 ? 2 : 1)
					stack.append("*")
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

	private func calculate(_ tokens: [String]) -> Int {
		var tokenStack: [String] = []

		for state in tokens {
			if !["+", "-", "*"].contains(state) {
				tokenStack.append(state)
			} else {
				let state1 = Int(tokenStack.removeLast())!
				let state2 = Int(tokenStack.removeLast())!

				let result = NSExpression(format: "\(state1) \(state) \(state2)").expressionValue(with: nil, context: nil) as! Int
				tokenStack.append(String(result))
			}
		}

		let value = Int(tokenStack.removeLast())!

		return value
	}

	private func rotateOperatorPrecedence(_ op: String, stack: inout [String], tokens: inout [String], plusWeight: Int = 1) {
		let comparison = ["+": plusWeight, "-": 1, "*": 1]
		while !stack.isEmpty && ["+", "-", "*"].contains(stack.last!) && ((comparison[op]! - comparison[stack.last!]!) <= 0) {
			tokens.append(stack.removeLast())
		}
	}
}
