import Foundation
import AdventOfCode

enum Field: String, CaseIterable {
	case byr, iyr, eyr, hgt, hcl, ecl, pid, cid

	static var requiredCases: [Field] {
		allCases.dropLast()
	}
}

public final class Day4: Day {
	struct Passport {
		let fields: [Field: String]

		var isValid: Bool {
			Field.requiredCases.allSatisfy(fields.keys.contains)
		}

		var hasValidData: Bool {
			let rules = [birthRule, issueRule, expirationRule, heightRule, hairRule, eyeRule, passportRule]
			return zip(Field.requiredCases, rules)
				.allSatisfy { field, rule in
					fields[field].flatMap { rule.run($0[...]).match } ?? false
				}
		}

		let birthRule = Parser.int.map { (1920...2002).contains($0) }
		let issueRule = Parser.int.map { (2010...2020).contains($0) }
		let expirationRule = Parser.int.map { (2020...2030).contains($0) }
		let heightRule = Parser.oneOf(
			Parser.int.map { (150...193).contains($0) }.skip(Parser.literal("cm")),
			Parser.int.map { (59...76).contains($0) }.skip(Parser.literal("in"))
		)
		let hairRule = Parser.prefix("#").take(Parser.prefix(while: \.isHexDigit)).map { $0.count == 6 }
		let eyeRule = Parser.oneOf(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].map(Parser.literal)).map { true }
		let passportRule = Parser.prefix(while: \.isNumber).map { $0.count == 9 }
	}

	var passports: [Passport] = []

	public init(input: String = Input().rawInput()) {
		super.init()

		let anyField = Field.allCases.map { `case` in
			Parser.literal(`case`.rawValue)
				.skip(":")
				.take(Parser.prefix(until: Parser.oneOf(" ", "\n")))
				.map { [`case`: String($0.1)] }
		}

		let passports = Parser
			.oneOf(anyField)
			.zeroOrMore()
			.map { $0.reduce([Field: String]()) { $0.merging(with: $1) } }
			.map(Passport.init)
			.zeroOrMore(separatedBy: Parser.whitespacesAndNewlines)

		self.passports = passports.run(input[...]).match ?? []
	}

	public override func part1() -> String {
		let count = passports.count(where: { $0.isValid })
		return "\(count)"
	}

	public override func part2() -> String {
		let count = passports.count(where: { $0.hasValidData })
		return "\(count)"
	}
}
