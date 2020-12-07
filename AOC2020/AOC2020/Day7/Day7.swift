import Foundation
import AdventOfCode

public final class Day7: Day {
	private var input: [String] = []
	private var bags: [String: [(color: String, quantity: Int)]] = [:]

	let firstPartRegexPattern = "^(.+) bags contain"
	let containingPattern = "(\\d+) (.+) bag" // or "no other bags"

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		super.init()
		self.input = input

		let firstRegex = Regex(pattern: firstPartRegexPattern)
		let lastRegex = Regex(pattern: containingPattern)

		for line in input {
			let containingBag = firstRegex.matches(in: line)?.matches ?? []
			let rest = line.components(separatedBy: "contain")[1].trimmingCharacters(in: .whitespaces)

			let containingBagName = containingBag[1]
			bags[containingBagName] = (bags[containingBagName] ?? [])

			let split = rest.components(separatedBy: ",")
			for section in split {
				guard !section.hasPrefix("no other bags") else { continue }
				let containedBag = lastRegex.matches(in: section)?.matches ?? []
				bags[containingBagName, default: []].append((containedBag[2], Int(containedBag[1])!))
			}
		}
	}

	public override func part1() -> String {
		// perform a bottom-up search of bags containing "shiny gold"
		var containedBags: [String: [String]] = [:]
		for (container, containing) in bags {
			for (contained, _) in containing {
				containedBags[contained, default: []].append(container)
			}
		}

		var uniqueColors: Set<String> = []

		var colors = containedBags["shiny gold"]!

		while let color = colors.popLast() {
			if uniqueColors.insert(color).inserted {
				colors.append(contentsOf: containedBags[color] ?? [])
			}
		}

		return String(uniqueColors.count)
	}

	public override func part2() -> String {
		// perform a top-down count of contained bags within "shiny gold"
		var totalBags = 0
		var allBags = bags["shiny gold"]!

		while let bag = allBags.popLast() {
			totalBags += bag.quantity
			for (name, count) in bags[bag.color]! {
				allBags.append((name, bag.quantity * count))
			}
		}

		return String(totalBags)
	}
}
