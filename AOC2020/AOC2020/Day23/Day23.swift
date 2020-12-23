import Foundation
import AdventOfCode

public final class Day23: Day {
	private let input = "963275481"

	public init(input: String = Input().trimmedRawInput()) {
		super.init()
	}

	public override func part1() -> String {
		let ints = input.exploded().map { Int($0)! }

		var cups = ints

		var currentCup = cups[0]

		func move() {
			let currentIndex_i = cups.firstIndex(of: currentCup)!

			let a = cups[(currentIndex_i + 1) % cups.count]
			let b = cups[(currentIndex_i + 2) % cups.count]
			let c = cups[(currentIndex_i + 3) % cups.count]

			cups.removeAll(where: { $0 == a })
			cups.removeAll(where: { $0 == b })
			cups.removeAll(where: { $0 == c })

			var destination = currentCup

			repeat {
				destination -= 1
				if destination < cups.min()! {
					destination = cups.max()!
				}
			} while [currentCup, a, b, c].contains(destination) && !cups.contains(destination)

			let destinationIndex = cups.firstIndex(of: destination)!
			cups.insert(contentsOf: [a, b, c], at: (destinationIndex + 1) % cups.count)

			let currentIndex = cups.firstIndex(of: currentCup)!
			currentCup = cups[(currentIndex + 1) % cups.count]
		}

		for _ in (0..<100) {
			move()
		}

		let indexOfOne: Int = cups.firstIndex(of: 1)!
		let result = (0..<cups.count-1)
			.map { (i: Int) -> Int in cups[(indexOfOne + i + 1) % cups.count] }
			.map { String($0) }
			.joined()

		return result
	}

	public override func part2() -> String {
		let inputInts = input.exploded().map { Int($0)! }
		let sequence = inputInts + (10...1_000_000)

		var currentCup = CircularList(value: 9)
		var lookupTable: [Int: CircularList<Int>] = [sequence[0]: currentCup]

		for n in sequence.dropFirst() {
			currentCup = currentCup.insertAfter(n)
			lookupTable[n] = currentCup
		}

		currentCup = currentCup.advance(by: 1)

		func move() {
			let a = currentCup.advance(by: 1).value
			let b = currentCup.advance(by: 2).value
			let c = currentCup.advance(by: 3).value

			currentCup = currentCup.advance(by: 1).remove().left
			currentCup = currentCup.advance(by: 1).remove().left
			currentCup = currentCup.advance(by: 1).remove().left

			var destination = currentCup.value

			repeat {
				destination = destination - 1
				if destination == 0 {
					destination = 1_000_000
				}
			} while [currentCup.value, a, b, c].contains(destination)

			var node = lookupTable[destination]!
			node = node.insertAfter(a)
			lookupTable[a] = node
			node = node.insertAfter(b)
			lookupTable[b] = node
			node = node.insertAfter(c)
			lookupTable[c] = node

			currentCup = currentCup.advance(by: 1)
		}

		for _ in (0..<10_000_000) {
			move()
		}

		let id = lookupTable[1]!
		let a = id.advance(by: 1).value
		let b = id.advance(by: 2).value
		let result = a * b

		return "\(result)"
	}
}
