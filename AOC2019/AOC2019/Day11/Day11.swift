import Foundation
import AdventOfCode

public final class Day11: Day {
    class Program {
        enum Halt: Equatable {
            case end
            case output(Int)
            
            var value: Int {
                switch self {
                case .end: return 0
                case .output(let value): return value
                }
            }
        }
        
        var tape: [Int: Int] = [:]
        
        var input: Int?
        private var pc = 0
        private var relativeBase = 0
        
        init(input: [Int], input1: Int?) {
            input.enumerated().forEach { idx, e in
                self.tape[idx] = e
            }
            self.input = input1
        }
        
        func get(parameter: Int, incr: Int) -> Int {
            if parameter == 0 {
                return tape[tape[pc + incr, default: 0], default: 0]
            } else if parameter == 1 {
                return tape[pc + incr, default: 0]
            } else if parameter == 2 {
                return tape[tape[pc + incr, default: 0] + relativeBase, default: 0]
            } else {
                fatalError("Invalid parameter")
            }
        }
        
        func set(value: Int, parameter: Int, incr: Int) {
            if parameter == 0 {
                tape[tape[pc + incr, default: 0]] = value
            } else if parameter == 1 {
                fatalError("Can't write in immediate mode1")
            } else if parameter == 2 {
                tape[tape[pc + incr, default: 0] + relativeBase] = value
            } else {
                fatalError("Invalid parameter")
            }
        }
        
        func run() -> Halt {
            while tape[pc] != 99 {
                // 3rd 2nd 1st param
                let (a, b, c, op) = parsedOpCode(tape[pc]!)
                
                //print("op: \(op)")
                
                if op == 1 {
                    let r1 = get(parameter: c, incr: 1)
                    let r2 = get(parameter: b, incr: 2)
                    set(value: r1 + r2, parameter: a, incr: 3)
                    pc += 4
                } else if op == 2 {
                    let r1 = get(parameter: c, incr: 1)
                    let r2 = get(parameter: b, incr: 2)
                    
                    // not immediate, since a write
                    set(value: r1 * r2, parameter: a, incr: 3)
                    pc += 4
                } else if op == 3 {
                    // not immediate, since a write
                    if let input = self.input {
                        self.input = nil
                        set(value: input, parameter: c, incr: 1)
                    } else {
                        fatalError("Missing required input!")
                    }
                    pc += 2
                } else if op == 4 {
                    let r1 = get(parameter: c, incr: 1)
                    pc += 2
                    return .output(r1)
                } else if op == 5 {
                    let r1 = get(parameter: c, incr: 1)
                    let r2 = get(parameter: b, incr: 2)
                    
                    if r1 != 0 {
                        pc = r2
                    } else {
                        pc += 3
                    }
                } else if op == 6 {
                    let r1 = get(parameter: c, incr: 1)
                    let r2 = get(parameter: b, incr: 2)
                    
                    if r1 == 0 {
                        pc = r2
                    } else {
                        pc += 3
                    }
                } else if op == 7 {
                    let r1 = get(parameter: c, incr: 1)
                    let r2 = get(parameter: b, incr: 2)
                    
                    if r1 < r2 {
                        set(value: 1, parameter: a, incr: 3)
                    } else {
                        set(value: 0, parameter: a, incr: 3)
                    }
                    pc += 4
                } else if op == 8 {
                    let r1 = get(parameter: c, incr: 1)
                    let r2 = get(parameter: b, incr: 2)
                    
                    if r1 == r2 {
                        set(value: 1, parameter: a, incr: 3)
                    } else {
                        set(value: 0, parameter: a, incr: 3)
                    }
                    pc += 4
                } else if op == 9 {
                    let r1 = get(parameter: c, incr: 1)
                    relativeBase += r1
                    pc += 2
                } else {
                    fatalError("Invalid opcode encountered! \(tape[pc]!)")
                }
            }
            return .end
        }
        
        func parsedOpCode(_ value: Int) -> (A: Int, B: Int, C: Int, Op: Int) {
            var codes = value.exploded()
            
            if codes.count < 5 {
                codes = Array(repeating: 0, count: (5 - codes.count)) + codes
            }
            // opCode 02, 0 is not read
            codes.remove(at: 3)
            return (codes[0], codes[1], codes[2], codes[3])
        }
    }

    public enum Direction: String {
        case left = "<"
        case up = "^"
        case right = ">"
        case down = "v"
        
        func goLeft() -> Direction {
            switch self {
            case .left: return .down
            case .up: return .left
            case .right: return .up
            case .down: return .right
            }
        }
        
        func goRight() -> Direction {
            switch self {
            case .left: return .up
            case .up: return .right
            case .right: return .down
            case .down: return .left
            }
        }
    }
    
    func advance(by direction: Direction, position: inout Position) {
        switch direction {
        case .left:
            position.x -= 1
        case .up:
            position.y -= 1
        case .right:
            position.x += 1
        case .down:
            position.y += 1
        }
    }

    let input: [Int]
    
    public init(input: [Int] = Input().trimmedRawInput().components(separatedBy: ",").map { Int($0)! }) {
        self.input = input
    }
    
    public override func part1() -> String {
        let program = Program(input: input, input1: 0)
        var output: Program.Halt = .output(-1)
        
        var positionsToColor: [Position: Int] = [Position.zero: 0]
        var current = Position.zero
        var direction = Direction.up
        
        while output != Program.Halt.end {
            program.input = positionsToColor[current, default: 0]
            output = program.run()
            
            let color = output.value
            
            program.input = positionsToColor[current, default: 0]
            output = program.run()
            
            if output.value == 0 {
                direction = direction.goLeft()
            } else {
                direction = direction.goRight()
            }
            
            positionsToColor[current] = color
            advance(by: direction, position: &current)
        }
                
        return String(positionsToColor.keys.count)
    }
    
    public override func part2() -> String {
        let program = Program(input: input, input1: 1)
        var output: Program.Halt = .output(-1)
        
        var positionsToColor: [Position: Int] = [Position.zero: 1]
        var current = Position.zero
        var direction = Direction.up
        
        while output != Program.Halt.end {
            program.input = positionsToColor[current, default: 0]
            output = program.run()
            
            let color = output.value
            
            program.input = positionsToColor[current, default: 0]
            output = program.run()
            
            if output.value == 0 {
                direction = direction.goLeft()
            } else {
                direction = direction.goRight()
            }
            
            positionsToColor[current] = color
            advance(by: direction, position: &current)
        }

        let maxX = positionsToColor.keys.map { $0.x }.max()!
        let maxY = positionsToColor.keys.map { $0.y }.max()!

        (0...maxY).forEach { y in
            var result = ""
            (0..<maxX).forEach { x in
                if positionsToColor[Position(x: x, y: y)] == 1 {
                    result += "⬜️"
                } else {
                    result += "⬛️"
                }
            }
            print(result)
        }
        
        
        return String(positionsToColor.keys.count)
    }
}
