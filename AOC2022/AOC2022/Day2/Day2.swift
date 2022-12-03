import Foundation
import AdventOfCode

// a for rock, b for paper, c for sics
// (1 for Rock, 2 for Paper, and 3 for Scissors)
// X for Rock, Y for Paper, and Z fo

public final class Day2: Day {
    private let lines: [String]

    public init(rawInput: [String] = Input().trimmedInputCharactersByNewlines()) {
        self.lines = rawInput
        super.init()
    }

	public override func part1() -> String {

        //  3 if the round was a draw, and 6 if you won

        var score = 0

        var rounds: [(String, String)] = []
        for line in lines {
            rounds.append((line.words[0], line.words[1]))

            let op = line.words[0]
            let me = line.words[1]

            if op == "A" { // rock
                if me == "X" { // rock
                    score += 1
                    score += 3 // draw
                } else if me == "Y" { // paper
                    score += 2
                    score += 6
                } else if me == "Z" { // sci
                    score += 3
                    score += 0
                }
            }
            else if op == "B" { // paper
                if me == "X" { // rock
                    score += 1
                    score += 0 // lose
                } else if me == "Y" { // paper
                    score += 2
                    score += 3 // draw
                } else if me == "Z" { // sci
                    score += 3
                    score += 6
                }
            }
            else if op == "C" { // sci
                if me == "X" { // rock
                    score += 1
                    score += 6 // lose
                } else if me == "Y" { // paper
                    score += 2
                    score += 0
                } else if me == "Z" { // sci
                    score += 3
                    score += 3 // draw
                }
            }
        }

        return score.string
	}
	
	public override func part2() -> String {
        // X means you need to lose,
        // Y means you need to end the round in a draw,
        // and Z means you need to win. Good luck!"

        // (1 for Rock, 2 for Paper, and 3 for Scissors)

        var score = 0

        var rounds: [(String, String)] = []
        for line in lines {
            rounds.append((line.words[0], line.words[1]))

            let op = line.words[0]
            let me = line.words[1]

            if op == "A" { // rock
                if me == "X" { // lose
                    score += 0
                    score += 3
                } else if me == "Y" { // draw
                    score += 3
                    score += 1
                } else if me == "Z" { // win
                    score += 6
                    score += 2
                }
            }
            else if op == "B" { // paper
                if me == "X" { // lose
                    score += 0
                    score += 1
                } else if me == "Y" { // draw
                    score += 3
                    score += 2
                } else if me == "Z" { // win
                    score += 6
                    score += 3
                }
            }
            else if op == "C" { // sci
                if me == "X" { // lose
                    score += 0
                    score += 2
                } else if me == "Y" { // draw
                    score += 3
                    score += 3
                } else if me == "Z" { // win
                    score += 6
                    score += 1
                }
            }
        }

        return score.string
    }
}
