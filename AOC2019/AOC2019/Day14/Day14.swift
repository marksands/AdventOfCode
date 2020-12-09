import Foundation
import AdventOfCode

public final class Day14: Day {
	var input: [String] = []

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		super.init()

		self.input = input
	}

	public override func part1() -> String {
		struct Ore: Hashable {
			let ore: String
			let quantity: Int
		}
		
		var parents: [Ore: [Ore]] = [:]
		var fuel: Ore!

		for line in input {
			let required_to_produced = line.components(separatedBy: " => ")
			let produced = required_to_produced[1].trimmingCharacters(in: .whitespaces)
			let producedComponents = produced.components(separatedBy: " ") // 2 PJBZT

			let ore = Ore(ore: producedComponents[1], quantity: Int(producedComponents[0])!)
			parents[ore] = []

			if ore.ore == "FUEL" {
				fuel = ore
			}

			let required = required_to_produced[0]
			for ore_line in required.components(separatedBy: ",") {
				let sanitized = ore_line.trimmingCharacters(in: .whitespaces)
				let sanitizedComponents = sanitized.components(separatedBy: " ") // 6 WBVJ
				let required_ore = Ore(ore: sanitizedComponents[1], quantity: Int(sanitizedComponents[0])!)
				parents[ore]!.append(required_ore)
			}
		}

		print(parents)
		let required_ores = parents[fuel!]!

		var queue: [Ore] = required_ores

		var total = 0

		func process_each_parent(of parent: Ore) -> Int {
			guard parent.ore != "ORE" else { return parent.quantity }

			var total = 0

			for each_parent in parents[parent] ?? [] {
				total += (parent.quantity * process_each_parent(of: each_parent))
			}

			return total
		}

		let s = process_each_parent(of: fuel)
		print("FOUND: \(s)")
		print()
//
//		while let ore = queue.popLast() {
//			//total += ore.quantity
//			let this_ones_parents = parents[ore] ?? []
//			for p in this_ones_parents {
//				total += ore.quantity * p.quantity
//			}
//			queue.append(contentsOf: this_ones_parents)
//		}

		// 146 is too low
//        return "\(total)"
		return ""
    }
    
    public override func part2() -> String {
        fatalError()
    }
}
