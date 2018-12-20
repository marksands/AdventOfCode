import Foundation

extension InstructionCode {
    static func inst(from value: String) -> InstructionCode {
        switch value {
        case "addr": return .addr
        case "addi": return addi
        case "mulr": return .mulr
        case "muli": return .muli
        case "banr": return .banr
        case "bani": return .bani
        case "borr": return .borr
        case "bori": return .bori
        case "setr": return .setr
        case "seti": return .seti
        case "gtir": return .gtir
        case "gtri": return .gtri
        case "gtrr": return .gtrr
        case "eqir": return .eqir
        case "eqri": return .eqri
        case "eqrr": return .eqrr
        default: fatalError()
        }
    }
}

public final class Day19: Day {
    private let input = Input().trimmedRawInput()
    
    public override func part1() -> String {
        let boundReg = 4 // from input
        var ip = 0
        var registers: [Int] = [0,0,0,0,0,0]
        
        let codeRegs = input.components(separatedBy: .newlines).map { line -> (InstructionCode, Int, Int, Int) in
            let components = String(line).components(separatedBy: .whitespaces)
            let instructionCode = InstructionCode.inst(from: components[0])
            let (a, b, c) = (Int(components[1])!, Int(components[2])!, Int(components[3])!)
            return (instructionCode, a, b, c)
        }
        
        // 5_920_252 iterations for part 1
        while true {
            registers[boundReg] = ip
            codeRegs[ip].0.operate([codeRegs[ip].0.rawValue, codeRegs[ip].1, codeRegs[ip].2, codeRegs[ip].3], registers: &registers)
            ip = registers[boundReg]
            ip += 1
        }
    }
    
    public override func part2() -> String {
        // TODO: I manually summed the factors of register [1]
        return super.part2()
    }
}
