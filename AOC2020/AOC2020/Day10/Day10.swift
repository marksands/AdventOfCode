import Foundation
import AdventOfCode

public final class Day10: Day {
	private var numbers: [Int] = []

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		super.init()
		self.numbers = input.map { Int($0)! }
	}

	public override func part1() -> String {
		var sorted = numbers.sorted()
		sorted.insert(0, at: 0)
		sorted.append(sorted.max()! + 3)

		let differences = sorted
			.eachPair()
			.map { $1 - $0 }

		let result = differences.count(where: { $0 == 1 }) * differences.count(where: { $0 == 3 })

		return String(result)
	}

	public override func part2() -> String {
		var sorted = numbers.sorted()
		sorted.insert(0, at: 0)
		sorted.append(sorted.max()! + 3)

		var branchCountCache: [Int: Int] = [:]

		func branchCount(for node: Int) -> Int {
			guard let nodeIndex = sorted.firstIndex(of: node) else {
				return 0
			}

			if let count = branchCountCache[node] {
				return count
			}

			let maxNodeIndex = min(nodeIndex + 3, sorted.count-1)
			if maxNodeIndex >= nodeIndex+1 {
				let count = sorted[nodeIndex+1...maxNodeIndex]
					.lazy
					.filter { $0 - node <= 3 }
					.map { branchCount(for: $0) }
					.reduce(into: 0, +=)
				branchCountCache[node] = count
				return count
			} else {
				branchCountCache[node] = 1
				return 1
			}
		}

		let result = branchCount(for: 0)

		return "\(result)"
	}
}
