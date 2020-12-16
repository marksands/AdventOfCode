import Foundation
import AdventOfCode

public final class Day16: Day {
	private var input: [String] = []

	struct Rule: Equatable {
		let name: String
		let range1: [Int]
		let range2: [Int]
	}

	struct Ticket {
		let possibleClass: String
		let numbers: [Int]
	}

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		super.init()
		self.input = input
	}

	public override func part1() -> String {
		let rulesInput = """
		departure location: 36-626 or 651-973
		departure station: 38-134 or 142-966
		departure platform: 32-465 or 489-972
		departure track: 40-420 or 446-973
		departure date: 38-724 or 738-961
		departure time: 30-358 or 377-971
		arrival location: 48-154 or 166-965
		arrival station: 48-669 or 675-968
		arrival platform: 27-255 or 276-965
		arrival track: 37-700 or 720-955
		class: 50-319 or 332-958
		duration: 35-822 or 835-949
		price: 40-791 or 802-951
		route: 42-56 or 82-968
		row: 40-531 or 555-968
		seat: 49-681 or 695-962
		train: 31-567 or 593-953
		type: 42-840 or 855-949
		wagon: 31-165 or 176-962
		zone: 48-870 or 896-970
		"""

		var rules: [Rule] = []

		for line in rulesInput.components(separatedBy: "\n") {
			let nameToRanges = line.components(separatedBy: ": ")
			let ranges = String(nameToRanges[1]).components(separatedBy: " or ")
			let rs = ranges.map { range -> [Int] in
				let r = range.components(separatedBy: "-")
				return Array(Int(r[0])!...Int(r[1])!)
			}

			let rule = Rule(name: nameToRanges[0], range1: rs[0], range2: rs[1])
			rules.append(rule)
		}

		var badValues: [Int] = []

		for line in input {
			let ticketNumbers = line.components(separatedBy: ",").map { Int($0)! }

			for num in ticketNumbers {
				if !(rules.anySatisfy({ $0.range1.contains(num) || $0.range2.contains(num) })) {
					badValues.append(num)
				}
			}
		}

		return String(badValues.sum())
	}

	public override func part2() -> String {
		let rulesInput = """
		departure location: 36-626 or 651-973
		departure station: 38-134 or 142-966
		departure platform: 32-465 or 489-972
		departure track: 40-420 or 446-973
		departure date: 38-724 or 738-961
		departure time: 30-358 or 377-971
		arrival location: 48-154 or 166-965
		arrival station: 48-669 or 675-968
		arrival platform: 27-255 or 276-965
		arrival track: 37-700 or 720-955
		class: 50-319 or 332-958
		duration: 35-822 or 835-949
		price: 40-791 or 802-951
		route: 42-56 or 82-968
		row: 40-531 or 555-968
		seat: 49-681 or 695-962
		train: 31-567 or 593-953
		type: 42-840 or 855-949
		wagon: 31-165 or 176-962
		zone: 48-870 or 896-970
		"""

		var rules: [Rule] = []

		for line in rulesInput.components(separatedBy: "\n") {
			let nameToRanges = line.components(separatedBy: ": ")
			let ranges = String(nameToRanges[1]).components(separatedBy: " or ")
			let rs = ranges.map { range -> [Int] in
				let r = range.components(separatedBy: "-")
				return Array(Int(r[0])!...Int(r[1])!)
			}

			let rule = Rule(name: nameToRanges[0], range1: rs[0], range2: rs[1])
			rules.append(rule)
		}

		var badValues: [Int] = []
		var validTicketNumbers: [[Int]] = []

		for line in input {
			let ticketNumbers = line.components(separatedBy: ",").map { Int($0)! }

			var isValid = true
			for num in ticketNumbers {
				if !(rules.anySatisfy({ $0.range1.contains(num) || $0.range2.contains(num) })) {
					badValues.append(num)
					isValid = false
				}
			}

			if isValid {
				validTicketNumbers.append(ticketNumbers)
			}
		}

		var ruleOrder: [[String]] = []

		let myTicketNumbers = "127,89,149,113,181,131,53,199,103,107,97,179,109,193,151,83,197,101,211,191".components(separatedBy: ",").map { Int($0)! }

		for index in (0..<myTicketNumbers.count) {
			let columnOfTickets = validTicketNumbers.map { $0[index] }

			let possibleRules = rules.filter({ rule in
				columnOfTickets.allSatisfy { rule.range1.contains($0) || rule.range2.contains($0) }
			})


			ruleOrder.append(possibleRules.map { $0.name })
		}

		while ruleOrder.map({ $0.count }).sum() > 20 {
			for (idx, rules) in ruleOrder.enumerated() {
				if rules.count == 1 {
					let toRemove = rules[0]

					for (j, _) in ruleOrder.enumerated() {
						if j == idx { continue }
						ruleOrder[j].removeAll(where: { $0 == toRemove })
					}
				}
			}
		}

		var nums: [Int] = []

		for (i, t) in ruleOrder.flatMap({ $0 }).enumerated() {
			if t.hasPrefix("departure") {
				nums.append(myTicketNumbers[i])
			}
		}

		return String(nums.product())
	}
}
