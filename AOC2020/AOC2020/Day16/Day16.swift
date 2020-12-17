import Foundation
import AdventOfCode

public final class Day16: Day {
	private var fields: [Field] = []
	private var myTicketNumbers: [Int] = []
	private var ticketsInput: [[Int]] = []

	struct Field: Equatable {
		let name: String
		let range: [Int]
	}

	struct Ticket {
		let field: String
		let numbers: [Int]
	}

	public init(input: String = Input().trimmedRawInput()) {
		super.init()

		let groups = input.groups

		myTicketNumbers = groups[1].dropFirst("your ticket:\n".count).ints
		ticketsInput = groups[2].dropFirst("nearby tickets:\n".count).components(separatedBy: "\n").map { $0.ints }

		for line in groups[0].lines {
			let nameToRanges = line.components(separatedBy: ": ")
			let ranges = String(nameToRanges[1]).components(separatedBy: " or ")
			let rs = ranges.map { range -> [Int] in
				let r = range.components(separatedBy: "-")
				return Array(Int(r[0])!...Int(r[1])!)
			}

			let rule = Field(name: nameToRanges[0], range: (rs[0] + rs[1]))
			fields.append(rule)
		}
	}

	public override func part1() -> String {
		return String(processTickets().invalidValues.sum())
	}

	public override func part2() -> String {
		let validTicketNumbers = processTickets().validTickets

		var fieldOrder = (0..<myTicketNumbers.count).map { index -> [String] in
			let columnOfTickets = validTicketNumbers.map({ $0[index] })

			let possibleRules = fields.lazy.filter({ field in
				columnOfTickets.isContainedWithin(field.range)
			}).map { $0.name }

			return Array(possibleRules)
		}

		while !fieldOrder.allSatisfy({ $0.count == 1 }) {
			for (i, rules) in fieldOrder.enumerated() {
				if rules.count == 1 {
					let toRemove = rules[0]

					fieldOrder.indices.filter({ $0 != i }).forEach {
						fieldOrder[$0].removeAll(where: { $0 == toRemove })
					}
				}
			}
		}

		let result = fieldOrder.flatMap({ $0 }).enumerated()
			.lazy
			.filter { $1.hasPrefix("departure") }
			.product { myTicketNumbers[$0.offset] }

		return String(result)
	}

	private func processTickets() -> (invalidValues: [Int], validTickets: [[Int]]) {
		var badValues: [Int] = []
		var validTicketNumbers: [[Int]] = []

		for ticketNumbers in ticketsInput {
			var isValid = true
			for num in ticketNumbers {
				if !(fields.anySatisfy({ $0.range.contains(num) })) {
					badValues.append(num)
					isValid = false
				}
			}

			if isValid {
				validTicketNumbers.append(ticketNumbers)
			}
		}

		return (badValues, validTicketNumbers)
	}
}
