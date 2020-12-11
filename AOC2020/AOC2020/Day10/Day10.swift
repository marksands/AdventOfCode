import Foundation
import AdventOfCode

public final class Day10: Day {
	private var numbers: [Int] = []

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		super.init()
		var sortedInput = input.map { Int($0)! }.sorted()
		sortedInput.insert(0, at: 0)
		sortedInput.append(sortedInput.max()! + 3)
		self.numbers = sortedInput
	}

	public override func part1() -> String {
		let differences = numbers
			.eachPair()
			.map { $1 - $0 }

		let result = differences.count(where: { $0 == 1 }) * differences.count(where: { $0 == 3 })

		return String(result)
	}

	public override func part2() -> String {
		func branchCount(for node: Int, cache: inout [Int: Int]) -> Int {
			if let count = cache[node] {
				return count
			}

			let nodeIndex = numbers.firstIndex(of: node)!
			let maxNodeIndex = min(nodeIndex + 3, numbers.count-1)
			guard maxNodeIndex > nodeIndex else { return 1 }

			let count = numbers[nodeIndex+1...maxNodeIndex]
				.filter { $0 - node <= 3 }
				.map { branchCount(for: $0, cache: &cache) }
				.reduce(into: 0, +=)

			cache[node] = count

			return count
		}

		var cache: [Int: Int] = [:]
		let result = branchCount(for: 0, cache: &cache)

		return "\(result)"
	}
}
