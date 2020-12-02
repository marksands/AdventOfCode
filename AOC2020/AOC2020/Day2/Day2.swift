import Foundation
import AdventOfCode

public final class Day2: Day {
	struct PasswordPolicy {
		let low: Int
		let high: Int
		let character: Substring
		let phrase: Substring
	}

	private let policies: [PasswordPolicy]

	public init(lines: [String] = Input().trimmedInputCharactersByNewlines()) {
		let parser = Parser
			.int
			.skip(Parser.init(stringLiteral: "-"))
			.take(Parser.int)
			.skip(Parser.init(stringLiteral: " "))
			.take(Parser.prefix(upTo: ": "))
			.skip(Parser.init(stringLiteral: ": "))
			.take(Parser.remaining)

		let policies = lines.compactMap { line in
			parser.run(line[...]).match.map(PasswordPolicy.init)
		}

		self.policies = policies

		super.init()
	}

	public override func part1() -> String {
		var validCount = 0

		for policy in policies {
			let count = policy.phrase.count(where: { String($0) == policy.character })
			if count >= policy.low && count <= policy.high {
				validCount += 1
			}
		}

		return String(validCount)
	}

	public override func part2() -> String {
		var validCount = 0

		for policy in policies {
			let phrase = policy.phrase.exploded()
			let character = String(policy.character)

			if phrase[safe: policy.low - 1] == character &&
			   phrase[safe: policy.high - 1] != character {
				validCount += 1
			} else if phrase[safe: policy.low - 1] != character &&
					  phrase[safe: policy.high - 1] == character {
				validCount += 1
			}
		}

		return String(validCount)
	}
}
