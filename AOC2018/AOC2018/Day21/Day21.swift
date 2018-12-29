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
    
    public func disassemble2() {
        let ip = 4
        var r = [0,0,0,0,0,0]

        while true {
            r[5] = 65536
            r[2] = 5234604
            
            r[3] = r[5] & 255 // l8:
            r[2] = r[2] + r[3] // l9:
            r[2] = r[2] & 16777215 // l10:
            r[2] = r[2] * 65899 // l11:
            r[2] = r[2] & 16777215 // l12:
            r[3] = 256 > r[5] ? 1 : 0 // l13:
            
            r[4] = r[3] + r[4] // l14:
            if r[ip] == 28 { print(r) } // DELTEEME
            
            if r[3] == 1 {
                r[3] = r[2] == r[0] ? 1 : 0 // if reg 0 is equal to reg2 then it'll crash, so pay attention to reg2
                r[4] += r[3] //+1 or +1
                if r[4] > 30 {
                    print("HALT!") // ❌
                }
                if r[ip] == 28 { print(r) } // DELTEEME
            } else if r[3] == 0 {
                r[3] = 0
                //goto l18
            }
            
            while true { // l18
                r[1] = ((r[3] + 1) * 256) > r[5] ? 1 : 0
                r[4] += r[1] // ip +1 or +0
                if r[ip] == 28 { print(r) } // DELTEEME
                
                if r[1] == 1 {
                    r[5] = r[3]
                    break //goto 8 i.e., break out of inner loop
                } else if r[1] == 0 {
                    r[3] = r[3] + 1
                    //goto l18 // continue looping
                }
            }
        }
    }
    
    public func disassemble() {
        let ip = 4
        var r = [0,0,0,0,0,0]

        r[2] = 123
        r[2] = r[2] | 456
        r[2] = r[2] == 72 ? 1 : 0
        r[4] = r[2] + r[4]
        r[4] = 0
        r[2] = 0
        
//        1seti 123 0 2
//        2bani 2 456 2
//        3eqri 2 72 2
//        4addr 2 4 4
//        5seti 0 0 4
//        6seti 0 0 2
        
        while true {
//             7 bori 2 65536 5
            r[5] = r[2] | 65536
            
//            8 seti 5234604 6 2
            r[2] = 5234604
            
//            9 bani 5 255 3
            r[3] = r[5] & 255
            
//            10 addr 2 3 2
            r[2] = r[2] + r[3]
            
//            11 bani 2 16777215 2
            r[2] = r[2] & 16777215
            
//            12 muli 2 65899 2
            r[2] = r[2] * 65899
            
//            13 bani 2 16777215 2
            r[2] = r[2] & 16777215
            
//            14 gtir 256 5 3
            r[3] = 256 > r[5] ? 1 : 0
            
//            15 addr 3 4 4
            r[4] = r[4] + r[3]
            
//            16 addi 4 1 4
            r[4] = r[4] + 1
            
//            17 seti 27 2 4
            r[4] = 27
            
//            18 seti 0 0 3
            r[3] = 0
            
//            19 addi 3 1 1
            r[1] = r[3] + 1
            
//            20 muli 1 256 1
            r[1] = r[1] * 256

//            21 gtrr 1 5 1
            r[1] = r[1] > r[5] ? 1 : 0
            
//            22 addr 1 4 4
            r[4] = r[4] + r[1]
            
//            23 addi 4 1 4
            r[4] = r[4] + 1
            
//            24 seti 25 6 4
            r[4] = 25
            
//            25 addi 3 1 3
            r[3] = r[3] + 1
            
//            26 seti 17 7 4
            r[4] = 17
            
//            27 setr 3 4 5
            r[5] = r[3]
            
//            28 seti 7 8 4
            r[4] = 7
            
//            29 eqrr 2 0 3
            r[3] = r[2] == r[0] ? 1 : 0
            
//            30 addr 3 4 4
            r[4] = r[4] + r[3]
            
//            31 seti 5 6 4
            r[4] = 5
        }
    }
}
