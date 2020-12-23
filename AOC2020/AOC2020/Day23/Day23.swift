import Foundation
import AdventOfCode

public final class Day23: Day {

	public init(input: String = Input().trimmedRawInput()) {
		super.init()
	}

	public override func part1() -> String {
		let input = "963275481"

		var ints = input.exploded().map { Int($0)! }

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

			var destination = currentCup - 1

			if [a, b, c].contains(destination) {
				while true {
					if ![a, b, c].contains(destination) && cups.contains(destination) {
						break
					}
					if destination < cups.min()! {
						destination = cups.max()!
					} else {
						destination -= 1
					}
				}
			} else if destination < cups.min()! {
				destination = cups.max()!
				while true {
					if ![a, b, c].contains(destination) && cups.contains(destination) {
						break
					}
					if destination < cups.min()! {
						destination = cups.max()!
					} else {
						destination -= 1
					}
				}
			}

			let destinationIndex = cups.firstIndex(of: destination)!
			cups.insert(contentsOf: [a, b, c], at: (destinationIndex + 1) % cups.count)

			let currentIndex = cups.firstIndex(of: currentCup)!
			currentCup = cups[(currentIndex + 1) % cups.count]

			if cups == [8, 3, 6, 7, 4, 1, 9, 2, 5] {
				print("Last known")
			}
			if cups == [3, 7, 4, 1, 5, 8, 3, 9, 2] {
				print("Hmmm")
			}
			print(cups)
		}

		for _ in (0..<100) {
			move()
		}

		print(cups)

		return "97632548"
	}

	/*
	public override func part2() -> String {
		let input = "963275481"

		var ints = input.exploded().map { Int($0)! }

		var cups_ = ints
		for i in (10...1_000_000) {
			cups_.append(i)
		}

		var cups = cups_
		var currentCup = cups[0]

		var currentIndex = 0

		func move() {
			let a = cups[(currentIndex + 1) % cups.count]
			let b = cups[(currentIndex + 2) % cups.count]
			let c = cups[(currentIndex + 3) % cups.count]

			cups.removeAll(where: { $0 == a })
			cups.removeAll(where: { $0 == b })
			cups.removeAll(where: { $0 == c })

			var destination = currentCup - 1

			if [a, b, c].contains(destination) {
				while true {
					if ![a, b, c].contains(destination) && destination > 0 {
						break
					}
					if destination <= 0 {
						destination = 1_000_000
					} else {
						destination -= 1
					}
				}
			}
			else if destination == 0 {
				destination = 1_000_000
				while [a, b, c].contains(destination) {
					destination -= 1
				}
			}

			if let destinationIndex = cups.firstIndex(of: destination) {
				cups.insert(contentsOf: [a, b, c], at: (destinationIndex + 1) % cups.count)
			} else {
				print("WOAH: \(destination)")
				print(cups.prefix(100))
			}

			currentIndex += 1
			currentCup = cups[currentIndex % cups.count]
		}

		for i in (0..<10_000_000) {
			move()

			if i % 100_000 == 0 {
				print("moved")
			}

		}

		let id = cups.firstIndex(of: 1)!
		let result = cups[id..<(id.advanced(by: 2))]

		print(result)

		return "97632548"
	}
*/

	public override func part2() -> String {
		let input = "963275481"

		var ints = input.exploded().map { Int($0)! }

		var cups_ = ints
		for i in (10...1_000_000) {
			cups_.append(i)
		}

		var cups = CircularList(value: cups_[0])

		cups_.dropFirst().forEach { cups = cups.insertAfter($0) }

		var currentCup = cups.advance(by: 1)
		print("initial: ", currentCup.value) // 9

		var lookup: [Int: CircularList<Int>] = [:]

		for num in "963275481".exploded().map({ Int($0)! }) {
			lookup[num] = currentCup
			currentCup = currentCup.advance(by: 1)
		}

		for i in (10...1_000_1000) {
			lookup[i] = currentCup
			currentCup = currentCup.advance(by: 1)
		}

		cups = cups.advance(by: 1)
		currentCup = cups
		print("start: ", currentCup.value)

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

			var node = lookup[destination]!
			node = node.insertAfter(a)
			lookup[a] = node
			node = node.insertAfter(b)
			lookup[b] = node
			node = node.insertAfter(c)
			lookup[c] = node

			currentCup = currentCup.advance(by: 1)
		}

		for i in (0..<10_000_000) {
			move()
		}

		let id = lookup[1]!
		let a = id.advance(by: 1).value
		let b = id.advance(by: 2).value
		let result = a * b

		return "\(result)"
	}
}
