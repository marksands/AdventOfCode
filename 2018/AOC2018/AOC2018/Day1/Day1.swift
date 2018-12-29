import Foundation

public final class Day1: Day {
    private let frequencies = Input().inputCharactersByNewlines().compactMap(Int.init)
    
    public override func part1() -> String {
        return "\(frequencies.sum())"
    }
    
    public override func part2() -> String {
        return "\(part2Result())"
    }
    
    private func part2Result() -> Int {
        var current = 0
        var seeds = Set<Int>([0])
        
        for frequency in cycled(frequencies) {
            current += frequency
            if seeds.contains(current) {
                break
            }
            seeds.insert(current)
        }

        return current
    }
}
