import Foundation
import AdventOfCode

public final class Day13: Day {
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
        
        init(input: [Int], input1: Int?, free: Bool = false) {
            input.enumerated().forEach { idx, e in
                self.tape[idx] = e
            }
            if free {
                self.tape[0] = 2 // part 2 requirement
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
                        print("Missing input?")
                        //fatalError("Missing required input!")
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
    
    let input: [Int]
    
    public init(input: [Int] = Input().trimmedRawInput().components(separatedBy: ",").map { Int($0)! }) {
        self.input = input
    }
    
    public override func part1() -> String {
        let program = Program(input: input, input1: 0)
        var output: Program.Halt = .output(-1)
        
        //        var positionsToColor: [Position: Int] = [Position.zero: 0]
        //        var current = Position.zero
        
        var positions: [Position: Int] = [:]
        
        var cnt = 0
        while output != Program.Halt.end {
            //            program.input = positionsToColor[current, default: 0]
            let x = program.run()
            let y = program.run()
            output = program.run()
            
            positions[Position(x: x.value, y: y.value)] = output.value

            if output.value == 2 {
                cnt += 1
            }
            //
            //            let color = output.value
            //
            //            program.input = positionsToColor[current, default: 0]
            //            output = program.run()
            //
            //            if output.value == 0 {
            //                direction = direction.goLeft()
            //            } else {
            //                direction = direction.goRight()
            //            }
            //
            //            positionsToColor[current] = color
            //            advance(by: direction, position: &current)
        }
        
        let maxX = positions.keys.map { $0.x }.max()!
        let maxY = positions.keys.map { $0.y }.max()!

        (0...maxY).forEach { y in
            var result = ""
            (0...maxX).forEach { x in
                if positions[Position(x: x, y: y)] == 0 {
                    result += " "
                } else if positions[Position(x: x, y: y)] == 1 {
                    result += "W"
                } else if positions[Position(x: x, y: y)] == 2 {
                    result += "B"
                } else if positions[Position(x: x, y: y)] == 3 {
                    result += "🏓"
                } else if positions[Position(x: x, y: y)] == 4 {
                    result += "🏀"
                }
            }
            print(result)
        }
        
        return String(cnt)
    }
    
    public override func part2() -> String {
        let program = Program(input: input, input1: 0, free: true)
        var output: Program.Halt = .output(-1)
        
        var paddlePosition = Position.zero
        var ballPosition = Position.zero
        var score = 0

        while output != Program.Halt.end {
            let x = program.run()
            let y = program.run()
            output = program.run()

            
            if x.value == -1 && y.value == 0 {
                score = output.value
            } else {
                //ball
                if output.value == 4 {
                    ballPosition = Position(x: x.value, y: y.value)
                    if ballPosition.x > paddlePosition.x {
                        program.input = 1
                    } else if ballPosition.x < paddlePosition.x {
                        program.input = -1
                    } else if ballPosition.x == paddlePosition.x {
                        program.input = 0
                    }
                    // paddle
                } else if output.value == 3 {
                    // reset?
                    paddlePosition = Position(x: x.value, y: y.value)
                    //program.input = nil
                }
            }
        }
        
        return String(score)
    }
}


// WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
//W                                   W
//W BBBB BB    BB BBBBB  B B BBB BBBB W
//W BBBBBBB BBB  B BBBB BB BB   B  B  W
//W  B B     B   B  BBBBB   BBB   BBB W
//W BB   BB  BBB BB   BBB BB B  BB BB W
//W B BB B BBB  B    BBB  B   B   B   W
//W B  BB B            B    BB  BBBB  W
//W BB  B  B     B BBBBB B   BB BB  B W
//W B B  BB BBB  BBBBBBBBB   BB  BBBB W
//W B    B    BBB  BBB B      BBB  BB W
//W B BBB   B  B BB BB   B BB BB BBB  W
//W BBB  B B BB  B   BBB B  BBBB BBB  W
//W    B BBBBBB BB B   BBBBBBB B    B W
//W  B B BBBBBBB B  B   BBB  BB BB  B W
//W   B    B     B BBBBBBB B B BBBBBB W
//W                                   W
//W               🏀                   W
//W                                   W
//W                                   W
//W                 🏓                 W
//W                                   W
