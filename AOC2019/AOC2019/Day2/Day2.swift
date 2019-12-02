import Foundation
import AdventOfCode

public final class Day2: Day {
    class Program {
        var tape: [Int]
        
        private var pc = 0
        
        init(input: [Int]) {
            self.tape = input
        }
        
        func run() -> Int {
            while tape[pc] != 99 {
                let r1 = tape[tape[pc + 1]]
                let r2 = tape[tape[pc + 2]]

                let storePosition = tape[pc + 3]

                if tape[pc] == 1 {
                    tape[storePosition] = r1 + r2
                } else if tape[pc] == 2 {
                    tape[storePosition] = r1 * r2
                } else {
                    fatalError("Invalid opcode encountered! \(tape[pc])")
                }
                
                pc += 4
            }
            return tape[0]
        }
    }

    var program: Program
    let persistentInput: [Int]
    
    public init(input: [Int] = Input().rawInput().components(separatedBy: ",").compactMap(Int.init)) {
        var inputCopy = input
        inputCopy[1] = 12
        inputCopy[2] = 2
        self.persistentInput = inputCopy
        program = Program(input: inputCopy)
        super.init()
    }
    
    public override func part1() -> String {
        let zero = program.run()
        return String(zero)
    }
    
    public override func part2() -> String {
        for noun in (0...99) {
            for verb in (0...99) {
                var copy = self.persistentInput
                copy[1] = noun
                copy[2] = verb
                program = Program(input: copy)
                if program.run() == 19690720 {
                    return "\(100 * noun + verb)"
                }
            }
        }
        fatalError()
    }
}
