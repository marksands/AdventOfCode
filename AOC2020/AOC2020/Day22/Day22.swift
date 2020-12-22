import Foundation
import AdventOfCode

public final class Day22: Day {
	private var input: String = ""

	public init(input: String = Input().trimmedRawInput()) {
		super.init()
		self.input = input
	}

	public override func part1() -> String {
		var player1: [Int] = []
		var player2: [Int] = []

		let players = input.groups

		player1 = players[0].lines.dropFirst().map { Int($0)! }
		player2 = players[1].lines.dropFirst().map { Int($0)! }

		let total = player1.count + player2.count

		while player1.count < total && player2.count < total {
			let c1 = player1.removeFirst()
			let c2 = player2.removeFirst()

			if c1 > c2 {
				player1.append(contentsOf: [c1, c2])
			} else {
				player2.append(contentsOf: [c2, c1])
			}
		}

		let score1 = Array(player1.reversed()).enumerated().map { ($0 + 1) * $1 }.sum()
		let score2 = Array(player2.reversed()).enumerated().map { ($0 + 1) * $1 }.sum()
		return String(max(score1, score2))
	}

	public override func part2() -> String {
		var player1: [Int] = []
		var player2: [Int] = []

		let players = input.groups

		player1 = players[0].lines.dropFirst().map { Int($0)! }
		player2 = players[1].lines.dropFirst().map { Int($0)! }

    typealias GameResult = (player1IsWinner: Bool, score: Int)

		func combat(player1: inout [Int], player2: inout [Int], roundCombo: inout Set<[[Int]]>, total: Int) -> GameResult? {
			guard roundCombo.insert([player1, player2]).inserted else {
				return (true, 0)
			}

      if player1.count == total {
        let score = Array(player1.reversed()).enumerated().map { ($0 + 1) * $1 }.sum()
        return (true, score)
      } else if player2.count == total {
        let score = Array(player2.reversed()).enumerated().map { ($0 + 1) * $1 }.sum()
        return (false, score)
      }

			let c1 = player1.removeFirst()
			let c2 = player2.removeFirst()

			if c1 <= player1.count && c2 <= player2.count {
				var copyP1 = Array(player1.prefix(c1))
				var copyP2 = Array(player2.prefix(c2))
				let t = copyP1.count + copyP2.count
				var combos: Set<[[Int]]> = []

        var state: GameResult?
				while state == nil {
					state = combat(player1: &copyP1, player2: &copyP2, roundCombo: &combos, total: t)
				}

        if state!.player1IsWinner {
					player1.append(contentsOf: [c1, c2])
				} else {
					player2.append(contentsOf: [c2, c1])
				}
			} else {
				if c1 > c2 {
					player1.append(contentsOf: [c1, c2])
				} else {
					player2.append(contentsOf: [c2, c1])
				}
			}

      return nil
		}

		var roundCombinations: Set<[[Int]]> = []

    var state: GameResult?
		while state == nil {
			state = combat(player1: &player1, player2: &player2, roundCombo: &roundCombinations, total: player1.count + player2.count)
		}

		return "\(state!.score)"
	}
}
