import Foundation

enum InstructionCode: CaseIterable {
    case addr //= 1
    case addi //= 3
    case mulr //= 2
    case muli //= 13
    case banr //= 5
    case bani //= 0
    case borr //= 6
    case bori //= 10
    case setr //= 11
    case seti //= 8
    case gtir //= 15
    case gtri //= 4
    case gtrr //= 14
    case eqir //= 12
    case eqri //= 7
    case eqrr //= 9
    
    func operate(_ instruction: [Int], registers: inout [Int]) {
        switch self {
        case .addr: registers[instruction[3]] = registers[instruction[1]] + registers[instruction[2]]
        case .addi: registers[instruction[3]] = registers[instruction[1]] + instruction[2]
        case .mulr: registers[instruction[3]] = registers[instruction[1]] * registers[instruction[2]]
        case .muli: registers[instruction[3]] = registers[instruction[1]] * instruction[2]
        case .banr: registers[instruction[3]] = registers[instruction[1]] & registers[instruction[2]]
        case .bani: registers[instruction[3]] = registers[instruction[1]] & instruction[2]
        case .borr: registers[instruction[3]] = registers[instruction[1]] | registers[instruction[2]]
        case .bori: registers[instruction[3]] = registers[instruction[1]] | instruction[2]
        case .setr: registers[instruction[3]] = registers[instruction[1]]
        case .seti: registers[instruction[3]] = instruction[1]
        case .gtir: registers[instruction[3]] = instruction[1] > registers[instruction[2]] ? 1 : 0
        case .gtri: registers[instruction[3]] = registers[instruction[1]] > instruction[2] ? 1 : 0
        case .gtrr: registers[instruction[3]] = registers[instruction[1]] > registers[instruction[2]] ? 1 : 0
        case .eqir: registers[instruction[3]] = instruction[1] == registers[instruction[2]] ? 1 : 0
        case .eqri: registers[instruction[3]] = registers[instruction[1]] == instruction[2] ? 1 : 0
        case .eqrr: registers[instruction[3]] = registers[instruction[1]] == registers[instruction[2]] ? 1 : 0
        }
    }
}

fileprivate struct Sample {
    let before: [Int]
    let after: [Int]
    let instruction: [Int]
}

public final class Day16: Day {
    private let inputParts = Input().trimmedRawInput().components(separatedBy: "\n\n\n\n")
    
    public override func part1() -> String {
        let sampleCounts = samples().map { sample in
            InstructionCode.allCases.reduce(0) { seed, code in
                var registers = sample.before
                code.operate(sample.instruction, registers: &registers)
                return seed + (registers == sample.after ? 1 : 0)
            }
        }.filter { $0 >= 3 }.count

        return "\(sampleCounts)"
    }
    
    public override func part2() -> String {
        let input = inputParts[1]
        
        let instructionRegex = Regex(pattern: "^(\\d+) (\\d+) (\\d+) (\\d+)$")
        let instructions = input.components(separatedBy: .newlines).map { line -> [Int] in
            return instructionRegex.matches(in: line)!.matches.compactMap(Int.init)
        }
        
        var knownSet: [Int: InstructionCode] = [:]
        
        (0..<16).forEach { _ in
            samples().forEach { sample in
                var count = 0
                var lastCode: InstructionCode?
                
                for code in InstructionCode.allCases {
                    if !knownSet.values.contains(code) {
                        var after = sample.before
                        code.operate(sample.instruction, registers: &after)
                        if knownSet[sample.instruction[0]] == nil {
                            if after == sample.after {
                                count += 1
                                lastCode = code
                            }
                        }
                    }
                }
                
                if let code = lastCode, count == 1 {
                    knownSet[sample.instruction[0]] = code
                }
            }
        }
        
        var registers: [Int] = [0, 0, 0, 0]
        instructions.forEach { inst in
            knownSet[inst[0]]?.operate(inst, registers: &registers)
        }
        
        return "\(registers[0])"
    }
    
    private func samples() -> [Sample] {
        let input = inputParts[0].components(separatedBy: "\n\n")
        let beforeRegex = Regex(pattern: "^Before: \\[(\\d+), (\\d+), (\\d+), (\\d+)\\]")
        let instructionRegex = Regex(pattern: "(\\d+) (\\d+) (\\d+) (\\d+)")
        let afterRegex = Regex(pattern: "After:  \\[(\\d+), (\\d+), (\\d+), (\\d+)\\]")
        
        let samples = input.map { sets -> Sample in
            let before = beforeRegex.matches(in: sets)!.matches.compactMap(Int.init)
            let instruction = instructionRegex.matches(in: sets)!.matches.compactMap(Int.init)
            let after = afterRegex.matches(in: sets)!.matches.compactMap(Int.init)
            return Sample(before: before, after: after, instruction: instruction)
        }
        
        return samples
    }
}
