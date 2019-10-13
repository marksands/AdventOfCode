import Foundation
import AdventOfCode

public final class Day20: Day {
    private let input: Int

    public init(input: String = Input().trimmedRawInput()) {
        self.input = Int(input)!
        super.init()
    }
    
    public override func part1() -> String {
        var presents = Array(repeating: 0, count: input)
        
        let elf = (1...input).first(where: { elf in
            stride(from: elf, to: input, by: elf).forEach { houseNumber in
                presents[houseNumber] += elf * 10
            }
            return presents[elf] >= self.input
        }) ?? -1
        
        return "\(elf)"
    }
    
    public override func part2() -> String {
        var presents = Array(repeating: 0, count: input)
        
        let elf = (1...input).first(where: { elf in
            var giftCount = 0
            for houseNumber in stride(from: elf, to: input, by: elf) {
                presents[houseNumber] += elf * 11
                giftCount += 1
                if giftCount == 50 { break }
            }
            return presents[elf] >= self.input
        }) ?? -1
        
        return "\(elf)"
    }
}
