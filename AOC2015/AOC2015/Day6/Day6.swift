import Foundation
import AdventOfCode

public final class Day6: Day {
    struct Instruction {
        enum Action: String {
            case on = "turn on"
            case off = "turn off"
            case toggle = "toggle"
        }
        let start: Position
        let end: Position
        let action: Action
    }

    private let input = Input().trimmedInputCharactersByNewlines()
    private let instructions: [Instruction]

    public override init() {
        let instructionRegex = Regex(pattern: "^(toggle|turn on|turn off) (\\d+),(\\d+) through (\\d+),(\\d+)$")
        instructions = input.map { line -> Instruction in
            let matches = instructionRegex.matches(in: line)!.matches
            let positions = matches.compactMap(Int.init).chunks(ofSize: 2).map { Array($0) }.map { Position(x: $0[0], y: $0[1]) }
            return Instruction(start: positions[0], end: positions[1], action: Instruction.Action(rawValue: matches[1])!)
        }
        super.init()
    }

    public override func part1() -> String {
        var switches: [Position: Bool] = [:]

        instructions.forEach { instruction in
            (instruction.start.y...instruction.end.y).forEach { y in
                (instruction.start.x...instruction.end.x).forEach { x in
                    let position = Position(x: x, y: y)
                    switch instruction.action {
                    case .on: switches[position] = true
                    case .off: switches[position] = false
                    case .toggle: switches[position, default: false].toggle()
                    }
                }
            }
        }

        return String(switches.values.count(where: { $0 }))
    }

    public override func part2() -> String {
        var switches: [Position: Int] = [:]

        instructions.forEach { instruction in
            (instruction.start.y...instruction.end.y).forEach { y in
                (instruction.start.x...instruction.end.x).forEach { x in
                    let position = Position(x: x, y: y)
                    switch instruction.action {
                    case .on: switches[position, default: 0] += 1
                    case .off: switches[position, default: 0] = max(0, switches[position, default: 0] - 1)
                    case .toggle: switches[position, default: 0] += 2
                    }
                }
            }
        }
        return String(switches.values.sum())
    }
}
