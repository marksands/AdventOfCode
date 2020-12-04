import Foundation
import AdventOfCode

enum Field: String, CaseIterable {
	case byr
	case iyr
	case eyr
	case hgt
	case hcl
	case ecl
	case pid
	case cid
}

public final class Day4: Day {

	struct Passport {
		let fields: [Field: String]

		var valid: Bool {
			return fields.keys.count == 8 ||
			(isMissingCID && fields.keys.count == 7)
		}

		var isMissingCID: Bool {
			return !fields.keys.contains(Field.cid)
		}

		var isVeryValid: Bool {
			return isBirth && isIssue && isExpirationYear && isHeight && isHair && isEye && isPassport
		}

		var isBirth: Bool {
			fields.keys.contains(Field.byr) &&
				Int(fields[.byr]!)! >= 1920 &&
				Int(fields[.byr]!)! <= 2002
		}

		var isIssue: Bool {
			fields.keys.contains(Field.iyr) &&
				Int(fields[.iyr]!)! >= 2010 &&
				Int(fields[.iyr]!)! <= 2020
		}

		var isExpirationYear: Bool {
			fields.keys.contains(Field.eyr) &&
				Int(fields[.eyr]!)! >= 2020 &&
				Int(fields[.eyr]!)! <= 2030
		}

		var isHeight: Bool {
			guard fields.keys.contains(Field.hgt) else { return false }

			let parser = Parser.int.take(Parser.remaining).map { (i: Int, s: Substring) -> Bool in
				if s == "cm" {
					return (i >= 150 && i <= 193)
				} else if s == "in" {
					return (i >= 59 && i <= 76)
				} else {
					return false
				}
			}

			return parser.run(fields[.hgt]![...]).match ?? false
		}

		var isHair: Bool {
			guard fields.keys.contains(Field.hcl) else { return false }
			let hcl = fields[Field.hcl]!
			return hcl.hasPrefix("#") && hcl.dropFirst().count == 6
			//return fields[Field.hcl]!.count == 6
			//		hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.

		}

		var isEye: Bool {
			guard fields.keys.contains(Field.ecl) else { return false }
			let ch = fields[Field.ecl]!
			return ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(ch)
		}

		var isPassport: Bool {
			guard fields.keys.contains(Field.pid) else { return false }
			return Int(fields[Field.pid, default: ""]) != nil && fields[Field.pid]!.count == 9
		}
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
			.map { fields in
				Passport(fields: fields.reduce([Field: String]()) { $0.merging(with: $1) })
			}
			.zeroOrMore(separatedBy: Parser.whitespacesAndNewlines)

		self.passports = passports.run(input[...]).match ?? []
	}

	public override func part1() -> String {
		let valid = passports.count(where: { $0.valid })
		return "\(valid)"
	}

	public override func part2() -> String {
		let valid = passports.count(where: { $0.isVeryValid })
		return "\(valid)"
	}
}
