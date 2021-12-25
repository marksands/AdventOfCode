import Foundation
import AdventOfCode

public final class Day21: Day {
	var player1Position: Int
	var player2Position: Int
	
	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		player1Position = input[0].ints.last!
		player2Position = input[1].ints.last!
	}

    public override func part1() -> String {
		var die = cycled(Array(1...100))
		let spaces = Array(1...10)
		var p1 = 0
		var p2 = 0

		for step in stride(from: 6, through: Int.max, by: 6) {
			var roll = die.next()! + die.next()! + die.next()!
			player1Position = spaces[(player1Position + roll - 1) % 10]
			p1 += player1Position

			if p1 >= 1000 {
				return (p2 * (step - 3)).string
			}

			roll = die.next()! + die.next()! + die.next()!
			player2Position = spaces[(player2Position + roll - 1) % 10]
			p2 += player2Position

			if p2 >= 1000 {
				return (p1 * step).string
			}
		}

		fatalError()
    }

    public override func part2() -> String {
		struct State: Hashable {
			var p1: Int
			var p2: Int
			var start1: Int
			var start2: Int
		}
		
		var memo: [State: (Int, Int)] = [:]
		let spaces = Array(1...10)
		
		func computeState(_ p1: Int, _ p2: Int, _ start1: Int, _ start2: Int) -> (p1: Int, p2: Int) {
			if p1 >= 21 { return (1, 0) }
			if p2 >= 21 { return (0, 1) }
			if let cached = memo[State(p1: p1, p2: p2, start1: start1, start2: start2)] { return cached }
			
			var winner1 = 0
			var winner2 = 0
			
			for a in (1...3) {
				for b in (1...3) {
					for c in (1...3) {
						let newStart = spaces[(start1 + (a + b + c) - 1) % 10]
						let newScore = p1 + newStart
						
						let (p1wins, p2wins) = computeState(p2, newScore, start2, newStart)
						winner1 += p2wins
						winner2 += p1wins
					}
				}
			}
			
			memo[State(p1: p1, p2: p2, start1: start1, start2: start2)] = (winner1, winner2)
			return (winner1, winner2)
		}
		
		let (winner1, winner2) = computeState(0, 0, player1Position, player2Position)
		return max(winner1, winner2).string
	}
}
