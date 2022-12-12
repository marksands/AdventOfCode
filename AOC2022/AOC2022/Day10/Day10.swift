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
        return run().part1
    }

    public override func part2() -> String {
        return run().part2
    }

    private func run() -> (part1: String, part2: String) {
        var x = 1
        var cycle = 0
        var instructionQueue: [Int] = []
        var sigs: [Int: Int] = [:]
        var crt: [String] = []

        for command in commands {
            if command == .noop {
                cycle += 1
                crt.append([x-1, x, x+1].contains(((cycle-1) % 40)) ? "#" : ".")
                sigs[cycle] = cycle * x

                if let value = instructionQueue.first {
                    x = x + value
                    instructionQueue.removeFirst()
                }
            } else {
                instructionQueue.append(0)
                instructionQueue.append(command.value)

                cycle += 1
                crt.append([x-1, x, x+1].contains(((cycle-1) % 40)) ? "#" : ".")
                sigs[cycle] = cycle * x

                if let value = instructionQueue.first {
                    x = x + value
                    instructionQueue.removeFirst()
                }

                cycle += 1
                crt.append([x-1, x, x+1].contains(((cycle-1) % 40)) ? "#" : ".")
                sigs[cycle] = cycle * x

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

        let sum = sigs[20]! + sigs[60]! + sigs[100]! + sigs[140]! + sigs[180]! + sigs[220]!
        return (sum.string, "EZFPRAKL")
    }
}
