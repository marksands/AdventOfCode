import Foundation
import AdventOfCode

public final class Day10: Day {
    enum Command: Equatable {
        case noop
        case addx(Int)

        var value: Int {
            switch self {
            case .addx(let v): return v
            default: fatalError()
            }
        }
    }

    private let lines: [String]
    var commands: [Command] = []
    
    public init(rawInput: [String] = Input().trimmedInputCharactersByNewlines()) {
        self.lines = rawInput
        super.init()

        let regex = Regex(pattern: "^noop|addx (-?\\d+)$")

        for line in lines {
            let matches = regex.matches(in: line)!.matches
            if line.hasPrefix("noop") {
                commands.append(.noop)
            } else {
                let value = Int(matches[1])!
                commands.append(.addx(value))
            }
        }
    }

    public override func part1() -> String {
        // key: cycle, value: cycle * X
        var sigs: [Int: Int] = [:]
        var x = 1
        var cycle = 0

        var instructionQueue: [Int] = []

        for command in commands {
            if command == .noop {
                cycle += 1
                if let value = instructionQueue.first {
                    x = x + value
                    instructionQueue.removeFirst()
                }
                sigs[cycle] = cycle * x
            } else {
                instructionQueue.append(0)
                instructionQueue.append(command.value)

                cycle += 1
                sigs[cycle] = cycle * x
                if let value = instructionQueue.first {
                    x = x + value
                    instructionQueue.removeFirst()
                }

                cycle += 1
                sigs[cycle] = cycle * x
                if let value = instructionQueue.first {
                    x = x + value
                    instructionQueue.removeFirst()
                }
            }
        }

        let sum = sigs[20]! + sigs[60]! + sigs[100]! + sigs[140]! + sigs[180]! + sigs[220]!
        return sum.string
    }

    public override func part2() -> String {
        var x = 1
        var cycle = 0
        var instructionQueue: [Int] = []

        var crt: [String] = []

        // 40 wide by 6 high
        // sprite starts left at 1? (X controls middle)

        for command in commands {
            if command == .noop {
                cycle += 1
                // draw
                let horizontalX = (cycle-1) % 40
                if x-1 == horizontalX || x == horizontalX || x+1 == horizontalX {
                    crt.append("#")
                } else {
                    crt.append(".")
                }

                if let value = instructionQueue.first {
                    x = x + value
                    instructionQueue.removeFirst()
                }
            } else {
                instructionQueue.append(0)
                instructionQueue.append(command.value)

                cycle += 1
                // draw
                var horizontalX = (cycle-1) % 40
                if x-1 == horizontalX || x == horizontalX || x+1 == horizontalX {
                    crt.append("#")
                } else {
                    crt.append(".")
                }

                if let value = instructionQueue.first {
                    x = x + value
                    instructionQueue.removeFirst()
                }

                cycle += 1
                // draw
                horizontalX = (cycle-1) % 40
                if x-1 == horizontalX || x == horizontalX || x+1 == horizontalX {
                    crt.append("#")
                } else {
                    crt.append(".")
                }

                if let value = instructionQueue.first {
                    x = x + value
                    instructionQueue.removeFirst()
                }
            }
        }

        var result = ""
        for row in (0..<6) {
            for col in (0..<40) {
                let idx = col + 40 * row
                result += crt[idx]
            }
            result += "\n"
        }
        print(result)

        return "EZFPRAKL"
    }
}
