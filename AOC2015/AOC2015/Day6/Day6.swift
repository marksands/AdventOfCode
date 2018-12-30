import Foundation
import AdventOfCode

public final class Day6: Day {
    struct Instruction {
        enum Action {
            case on
            case off
            case toggle
        }
        let start: Position
        let end: Position
        let action: Action
        
        var positions: [Position] {
            return (start.y...end.y).flatMap { y in
                (start.x...end.x).map { x in
                    Position.init(x: x, y: y)
                }
            }
        }
    }
    
    private let input = Input().trimmedInputCharactersByNewlines()
    private let instructions: [Instruction]
    
    public override init() {
        let instructionRegex = Regex(pattern: "^(toggle|turn)\\s?(on|off)? (\\d+),(\\d+) through (\\d+),(\\d+)$")
        instructions = input.compactMap { line -> Instruction? in
            if let matches = instructionRegex.matches(in: line)?.matches {
                let positions = matches.compactMap(Int.init).chunks(ofSize: 2).map { Array($0) }.map { Position(x: $0[0], y: $0[1]) }
                if matches[1] == "toggle" {
                    return Instruction(start: positions[0], end: positions[1], action: .toggle)
                } else if matches[2] == "on" {
                    return Instruction(start: positions[0], end: positions[1], action: .on)
                } else {
                    return Instruction(start: positions[0], end: positions[1], action: .off)
                }
            } else {
                return nil
            }
        }
        super.init()
    }
    
    public override func part1() -> String {
        var switches: [Position: Bool] = [:]
        
        instructions.forEach { instruction in
            instruction.positions.forEach { position in
                switch instruction.action {
                case .on: switches[position] = true
                case .off: switches[position] = false
                case .toggle: switches[position, default: false].toggle()
                }
            }
        }
        
        return String(switches.values.count(where: { $0 }))
    }
    
    public override func part2() -> String {
        var switches: [Position: Int] = [:]
        
        instructions.forEach { instruction in
            instruction.positions.forEach { position in
                switch instruction.action {
                case .on: switches[position, default: 0] += 1
                case .off: switches[position, default: 0] = max(0, switches[position, default: 0] - 1)
                case .toggle: switches[position, default: 0] += 2
                }
            }
        }
        
        return String(switches.values.sum())
    }
}
