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

		let score = Array(player1.reversed()).enumerated().map { index, c in
			(index + 1) * c
		}.sum()
		let score2 = Array(player2.reversed()).enumerated().map { index, c in
			(index + 1) * c
		}.sum()

		return String(max(score, score2))
	}

	public override func part2() -> String {
		var player1: [Int] = []
		var player2: [Int] = []

		let players = input.groups

		player1 = players[0].lines.dropFirst().map { Int($0)! }
		player2 = players[1].lines.dropFirst().map { Int($0)! }

		enum GameState: Equatable {
			case unknown
			case player1WonRound
			case player2WonRound
			case player1Wins(score: Int)
			case player2Wins(score: Int)

			var score: Int {
				switch self {
				case .player1Wins(score: let s): return s
				case .player2Wins(score: let s): return s
				default: return 0
				}
			}

			var player1WonGame: Bool {
				switch self {
				case .player1Wins: return true
				default: return false
				}
			}

			var player2WonGame: Bool {
				switch self {
				case .player2Wins: return true
				default: return false
				}
			}
		}

		// return true if P1 is winner
		func combat(player1: inout [Int], player2: inout [Int], roundCombo: inout Set<[[Int]]>, total: Int) -> GameState {
			guard roundCombo.insert([player1, player2]).inserted else {
				return .player1Wins(score: 0)
			}

			let c1 = player1.removeFirst()
			let c2 = player2.removeFirst()

			var roundState = GameState.unknown

			if c1 <= player1.count && c2 <= player2.count {
				var copyP1 = Array(player1.prefix(c1))
				var copyP2 = Array(player2.prefix(c2))
				let t = copyP1.count + copyP2.count
				var combos: Set<[[Int]]> = []

				var state = GameState.unknown
				while !state.player1WonGame && !state.player2WonGame {
					state = combat(player1: &copyP1, player2: &copyP2, roundCombo: &combos, total: t)
				}

				if state.player1WonGame {
					player1.append(contentsOf: [c1, c2])
					roundState = .player1WonRound
				} else if state.player2WonGame {
					player2.append(contentsOf: [c2, c1])
					roundState = .player2WonRound
				}
			} else {
				if c1 > c2 {
					player1.append(contentsOf: [c1, c2])
					roundState = .player1WonRound
				} else {
					player2.append(contentsOf: [c2, c1])
					roundState = .player2WonRound
				}
			}

			if player1.count == total {
				let score = Array(player1.reversed()).enumerated().map { index, c in (index + 1) * c }.sum()
				return .player1Wins(score: score)
			} else if player2.count == total {
				let score = Array(player2.reversed()).enumerated().map { index, c in (index + 1) * c }.sum()
				return .player2Wins(score: score)
			}

			return roundState
		}

		var roundCombinations: Set<[[Int]]> = []

		var state = GameState.unknown
		while !state.player1WonGame && !state.player2WonGame {
			state = combat(player1: &player1, player2: &player2, roundCombo: &roundCombinations, total: player1.count + player2.count)
		}

		return "\(state.score)"
	}
}
