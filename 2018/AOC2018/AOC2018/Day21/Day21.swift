import Foundation

public final class Day21: Day {
    let input = """
seti 123 0 2
bani 2 456 2
eqri 2 72 2
addr 2 4 4
seti 0 0 4
seti 0 0 2
bori 2 65536 5
seti 5234604 6 2
bani 5 255 3
addr 2 3 2
bani 2 16777215 2
muli 2 65899 2
bani 2 16777215 2
gtir 256 5 3
addr 3 4 4
addi 4 1 4
seti 27 2 4
seti 0 0 3
addi 3 1 1
muli 1 256 1
gtrr 1 5 1
addr 1 4 4
addi 4 1 4
seti 25 6 4
addi 3 1 3
seti 17 7 4
setr 3 4 5
seti 7 8 4
eqrr 2 0 3
addr 3 4 4
seti 5 6 4
"""
    
    public override func part1() -> String {
        let ip = 4
        
        let codeRegs = input.components(separatedBy: .newlines).map { line -> (InstructionCode, Int, Int, Int) in
            let components = String(line).components(separatedBy: .whitespaces)
            let instructionCode = InstructionCode.inst(from: components[0])
            let (a, b, c) = (Int(components[1])!, Int(components[2])!, Int(components[3])!)
            return (instructionCode, a, b, c)
        }
    
//        for start in (0...) {
            var registers: [Int] = [0,0,0,0,0,0]
            registers[ip] = 0

            for _ in (0...5000) {
                codeRegs[registers[ip]].0.operate([codeRegs[registers[ip]].0.rawValue, codeRegs[registers[ip]].1, codeRegs[registers[ip]].2, codeRegs[registers[ip]].3], registers: &registers)
                registers[ip] += 1
                
                if registers[ip] == 28 {
                    return "\(registers[2])"
                }
            }
//        }
        
        return ""
    }
    
    public override func part2() -> String {
        let ip = 4
        
        let codeRegs = input.components(separatedBy: .newlines).map { line -> (InstructionCode, Int, Int, Int) in
            let components = String(line).components(separatedBy: .whitespaces)
            let instructionCode = InstructionCode.inst(from: components[0])
            let (a, b, c) = (Int(components[1])!, Int(components[2])!, Int(components[3])!)
            return (instructionCode, a, b, c)
        }
        
        var seen = Set<Int>()
        var last = -1
        var registers: [Int] = [0,0,0,0,0,0]
        registers[ip] = 0
        
        // 14626276
        for _ in (0...) {
            codeRegs[registers[ip]].0.operate([codeRegs[registers[ip]].0.rawValue, codeRegs[registers[ip]].1, codeRegs[registers[ip]].2, codeRegs[registers[ip]].3], registers: &registers)
            registers[ip] += 1
            
            if registers[ip] == 28 {
                if seen.contains(registers[2]) {
                    return "\(last)"
                }
                seen.insert(registers[2])
                last = registers[2]
            }
        }
        
        return ""
    }
    
    /*
    public func disassemble(instruction: [Int], registers: inout [Int]) {
        var ip = 0

        l0: registers[2] = 123
        l1: registers[2] = register[2] & 456
        l2: registers[2] = register[2] == 72 ? 1 : 0
        l3: registers[4] = registers[2] == 1 ? goto l5 else if registers[2] == 0 goto l4 else { fatalError("Bad R[2] \(registers[2])") }
        l4: goto l1
        l5: registers[2] = 0
        l6: registers[5] = registers[2] | 65536
        l7: registers[2] = 5234604
        l8: registers[3] = registesr[5] & 255
        l9: registers[2] = registers[2] + registers[3]
        l10: registers[2] = registers[2] & 16777215
        l11: registers[2] = registers[2] * 65899
        l12: registers[2] = registers[2] & 16777215
        l13: registers[3] = 256 > registers[5] ? 1 : 0
        l14: registers[4] = registers[3] + registers[4]
        if registers[3] == 1 {
            goto l16
        } else if registers[3] == 0 {
            goto l15
        }
        l15: goto l17
        l16: goto l28
        l17: registers[3] = 0
        l18: registers[1] = registers[3] + 1
        l19: registers[1] = registers[1] * 256
        l20: registers[1] = registers[1] > registers[5] ? 1 : 0
        l21: registers[4] = registers[1] + registers[4]
        if registers[1] == 1 {
            goto l23
        } else if registers[1] == 0 {
            goto l22
        }
        l22: goto l24
        l23: goto l26
        l24: registers[3] = registers[3] + 1
        l25: goto 18
        l26: registers[5] = registers[3]
        l27: goto 8
        l28: registers[3] = registers[2] == registers[0] ? 1 : 0 // if reg 0 is equal to reg2 then it'll crash, so pay attention to reg2
        l29: registers[4] = registers[3] + registers[4]
        if registers[3] == 1 ? {
            goto l31 // ❌
        } else if registers[3] == 0 {
            goto l30
        }
        l30: goto 6
    }
     */
}
