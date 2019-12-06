import Foundation
import AdventOfCode

public final class Day5: Day {
    class Program {
        var tape: [Int]
        
        var input = 5
        private var pc = 0
        
        init(input: [Int], value: Int) {
            self.tape = input// + Array(repeating: 0, count: 1000)
            self.input = value
        }
        
        // Parameters that an instruction writes to will never be in immediate mode.

        func run() -> Int {
            while tape[pc] != 99 {
                //  3  2   1st param
                let (a, b, c, op) = parsedOpCode(tape[pc])
                
                //let r1 = tape[tape[pc + 1]]
                //let r2 = tape[tape[pc + 2]]
                //let storePosition = tape[pc + 3]
                
                if op == 1 {
                    let r1: Int
                    let r2: Int
                    if c == 0 {
                        r1 = tape[tape[pc + 1]]
                    } else {
                        r1 = tape[pc + 1]
                    }
                    if b == 0 {
                        r2 = tape[tape[pc + 2]]
                    } else {
                        r2 = tape[pc + 2]
                    }

                    // not immediate, since a write
                    tape[tape[pc + 3]] = r1 + r2
                    pc += 4
                } else if op == 2 {
                    let r1: Int
                    let r2: Int
                    if c == 0 {
                        r1 = tape[tape[pc + 1]]
                    } else {
                        r1 = tape[pc + 1]
                    }
                    if b == 0 {
                        r2 = tape[tape[pc + 2]]
                    } else {
                        r2 = tape[pc + 2]
                    }

                    // not immediate, since a write
                    tape[tape[pc + 3]] = r1 * r2
                    pc += 4
                } else if op == 3 {
                    // not immediate, since a write
                    tape[tape[pc + 1]] = input
                    pc += 2
                    // store input at address tape[tape[pc + 1]]
                    //Opcode 3 takes a single integer as input and saves it to the address given by its only parameter.
                    // For example, the instruction 3,50 would take an input value and store it at address 50.
                } else if op == 4 {
                    let r1: Int
                    if c == 0 {
                        r1 = tape[tape[pc + 1]]
                    } else {
                        r1 = tape[pc + 1]
                    }

                    let value = r1
                    print("VALUE", value)
                    pc += 2
                    // output tape[tape[pc + 1]
                    // Opcode 4 outputs the value of its only parameter. For example, the instruction 4,50 would output the value at address 50.
                    
                } else if op == 5 {
                    let r1: Int
                    let r2: Int
                    if c == 0 {
                        r1 = tape[tape[pc + 1]]
                    } else {
                        r1 = tape[pc + 1]
                    }
                    if b == 0 {
                        r2 = tape[tape[pc + 2]]
                    } else {
                        r2 = tape[pc + 2]
                    }

                    if r1 != 0 {
                        pc = r2
                    } else {
                        pc += 3
                    }
                } else if op == 6 {
                    let r1: Int
                    let r2: Int
                    if c == 0 {
                        r1 = tape[tape[pc + 1]]
                    } else {
                        r1 = tape[pc + 1]
                    }
                    if b == 0 {
                        r2 = tape[tape[pc + 2]]
                    } else {
                        r2 = tape[pc + 2]
                    }

                    if r1 == 0 {
                        pc = r2
                    } else {
                        pc += 3
                    }
                } else if op == 7 {
                    let r1: Int
                    let r2: Int
                    if c == 0 {
                        r1 = tape[tape[pc + 1]]
                    } else {
                        r1 = tape[pc + 1]
                    }
                    if b == 0 {
                        r2 = tape[tape[pc + 2]]
                    } else {
                        r2 = tape[pc + 2]
                    }

                    if r1 < r2 {
                        tape[tape[pc + 3]] = 1
                    } else {
                        tape[tape[pc + 3]] = 0
                    }
                    pc += 4
                } else if op == 8 {
                    let r1: Int
                    let r2: Int
                    if c == 0 {
                        r1 = tape[tape[pc + 1]]
                    } else {
                        r1 = tape[pc + 1]
                    }
                    if b == 0 {
                        r2 = tape[tape[pc + 2]]
                    } else {
                        r2 = tape[pc + 2]
                    }

                    if r1 == r2 {
                        tape[tape[pc + 3]] = 1
                    } else {
                        tape[tape[pc + 3]] = 0
                    }
                    pc += 4
                } else {
                    fatalError("Invalid opcode encountered! \(tape[pc])")
                }
            }
            return tape[0]
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
    
    public init(input: [Int] = Input().rawInput().components(separatedBy: ",").compactMap(Int.init)) {
//        self.input = input
        self.input = MyInput.components(separatedBy: ",").compactMap(Int.init)
        print(input.last)
//        self.input = "3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9".components(separatedBy: ",").compactMap(Int.init)
    }
    
    public override func part1() -> String {
        let program = Program.init(input: input, value: 5)
        let result = program.run()
        return String(result)
    }
    
    public override func part2() -> String {
        fatalError()
    }
}


let MyInput = "3,225,1,225,6,6,1100,1,238,225,104,0,1101,72,36,225,1101,87,26,225,2,144,13,224,101,-1872,224,224,4,224,102,8,223,223,1001,224,2,224,1,223,224,223,1102,66,61,225,1102,25,49,224,101,-1225,224,224,4,224,1002,223,8,223,1001,224,5,224,1,223,224,223,1101,35,77,224,101,-112,224,224,4,224,102,8,223,223,1001,224,2,224,1,223,224,223,1002,195,30,224,1001,224,-2550,224,4,224,1002,223,8,223,1001,224,1,224,1,224,223,223,1102,30,44,225,1102,24,21,225,1,170,117,224,101,-46,224,224,4,224,1002,223,8,223,101,5,224,224,1,224,223,223,1102,63,26,225,102,74,114,224,1001,224,-3256,224,4,224,102,8,223,223,1001,224,3,224,1,224,223,223,1101,58,22,225,101,13,17,224,101,-100,224,224,4,224,1002,223,8,223,101,6,224,224,1,224,223,223,1101,85,18,225,1001,44,7,224,101,-68,224,224,4,224,102,8,223,223,1001,224,5,224,1,223,224,223,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,7,677,226,224,102,2,223,223,1005,224,329,101,1,223,223,8,677,226,224,1002,223,2,223,1005,224,344,1001,223,1,223,1107,677,677,224,102,2,223,223,1005,224,359,1001,223,1,223,1107,226,677,224,102,2,223,223,1005,224,374,101,1,223,223,7,226,677,224,102,2,223,223,1005,224,389,101,1,223,223,8,226,677,224,1002,223,2,223,1005,224,404,101,1,223,223,1008,226,677,224,1002,223,2,223,1005,224,419,1001,223,1,223,107,677,677,224,102,2,223,223,1005,224,434,101,1,223,223,1108,677,226,224,1002,223,2,223,1006,224,449,101,1,223,223,1108,677,677,224,102,2,223,223,1006,224,464,101,1,223,223,1007,677,226,224,102,2,223,223,1006,224,479,101,1,223,223,1008,226,226,224,102,2,223,223,1006,224,494,101,1,223,223,108,226,226,224,1002,223,2,223,1006,224,509,101,1,223,223,107,226,226,224,102,2,223,223,1006,224,524,101,1,223,223,1107,677,226,224,102,2,223,223,1005,224,539,1001,223,1,223,108,226,677,224,1002,223,2,223,1005,224,554,101,1,223,223,1007,226,226,224,102,2,223,223,1005,224,569,101,1,223,223,8,226,226,224,102,2,223,223,1006,224,584,101,1,223,223,1008,677,677,224,1002,223,2,223,1005,224,599,1001,223,1,223,107,226,677,224,1002,223,2,223,1005,224,614,1001,223,1,223,1108,226,677,224,102,2,223,223,1006,224,629,101,1,223,223,7,677,677,224,1002,223,2,223,1005,224,644,1001,223,1,223,108,677,677,224,102,2,223,223,1005,224,659,101,1,223,223,1007,677,677,224,102,2,223,223,1006,224,674,101,1,223,223,4,223,99,226\n"
