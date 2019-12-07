import Foundation
import AdventOfCode

let rawInput = "3,8,1001,8,10,8,105,1,0,0,21,30,39,64,81,102,183,264,345,426,99999,3,9,1001,9,2,9,4,9,99,3,9,1002,9,4,9,4,9,99,3,9,1002,9,5,9,101,2,9,9,102,3,9,9,1001,9,2,9,1002,9,2,9,4,9,99,3,9,1002,9,3,9,1001,9,5,9,1002,9,3,9,4,9,99,3,9,102,4,9,9,1001,9,3,9,102,4,9,9,1001,9,5,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,99,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,99"

public final class Day7: Day {
    class Program {
        var tape: [Int]
        
        var input1 = 5
        var input2 = 0
        var input1Used = false
        private var pc = 0
        
        init(input: [Int], input1: Int, input2: Int) {
            self.tape = input// + Array(repeating: 0, count: 1000)
            self.input1 = input1
            self.input2 = input2
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
                    if !input1Used {
                        input1Used = true
                        tape[tape[pc + 1]] = input1
                    } else {
                        tape[tape[pc + 1]] = input2
                    }
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
                    if value != 0 {
                        return value
                    }
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
            return 0 // halt
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
    
    public override init() {
        self.input = rawInput.components(separatedBy: ",").compactMap(Int.init)
//        self.input = "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5".components(separatedBy: ",").compactMap(Int.init)
    }
    
    public override func part1() -> String {
        let values = [0, 1, 2, 3, 4].permutations().map { perm -> Int in
            let programA = Program(input: self.input, input1: perm[0], input2: 0)
            let programB = Program(input: self.input, input1: perm[1], input2: programA.run())
            let programC = Program(input: self.input, input1: perm[2], input2: programB.run())
            let programD = Program(input: self.input, input1: perm[3], input2: programC.run())
            let programE = Program(input: self.input, input1: perm[4], input2: programD.run())
            return programE.run()
        }
        return String(values.max()!)
    }
    
    public override func part2() -> String {
        let values = [5,6,7,8,9].permutations().map { perm -> Int in
            
            var maxThrust: Int = 0
            
            let programA = Program(input: self.input, input1: perm[0], input2: 0)
            let programB = Program(input: self.input, input1: perm[1], input2: programA.run())
            let programC = Program(input: self.input, input1: perm[2], input2: programB.run())
            let programD = Program(input: self.input, input1: perm[3], input2: programC.run())
            let programE = Program(input: self.input, input1: perm[4], input2: programD.run())

            while true {
                let lastInput = programE.run()
                maxThrust = max(maxThrust, lastInput)
                if lastInput == 0 { return maxThrust }

                programA.input2 = lastInput
                programB.input2 = programA.run()
                programC.input2 = programB.run()
                programD.input2 = programC.run()
                programE.input2 = programD.run()
            }
        }
        return String(values.max()!)
    }
}
