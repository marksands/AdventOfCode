import Foundation
import AdventOfCode

public final class Day5: Day {
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
        
        var input1 = 1
        var input2 = 1
        var input1Used = false
        private var pc = 0
        private var relativeBase = 0
        
        init(input: [Int], input1: Int, input2: Int) {
            input.enumerated().forEach { idx, e in
                self.tape[idx] = e
            }
            self.input1 = input1
            self.input2 = input2
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
                    if !input1Used {
                        input1Used = true
                        set(value: input1, parameter: c, incr: 1)
                    } else {
                        set(value: input2, parameter: c, incr: 1)
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
        let program = Program(input: input, input1: 1, input2: 1)
        var halt = Program.Halt.end
        while halt.value == 0 {
            halt = program.run()
        }
        return String(halt.value)
    }
    
    public override func part2() -> String {
        let program = Program(input: input, input1: 5, input2: 5)
        var halt = Program.Halt.end
        while halt.value == 0 {
            halt = program.run()
        }
        return String(halt.value)
    }
}
