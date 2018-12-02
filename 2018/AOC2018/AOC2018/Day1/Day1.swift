import Foundation

public final class Day1: Day {
    private let frequencies = Input().inputIntegersByNewlines()
    
    public override func part1() -> String {
        return "\(part1Result())"
    }
    
    public override func part2() -> String {
        return "\(part2Result())"
    }
    
    private func part1Result() -> Int {
        return frequencies.reduce(0, +)
    }

    private func part2Result() -> Int {
        var current = 0
        var seeds = Set<Int>()
        seeds.insert(0)
        
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
