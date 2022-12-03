import Foundation
import AdventOfCode

public final class Day3: Day {
    private let lines: [String]
    
    let table = {
        var result: [String: Int] = [:]
        (lowercaseLetters + uppercaseLetters)
            .enumerated()
            .forEach { i, value in
                result[String(value)] = i+1
            }
        return result
    }()
    
    public init(rawInput: [String] = Input().trimmedInputCharactersByNewlines()) {
        self.lines = rawInput
        super.init()
    }
    
    public override func part1() -> String {
        var sum = 0
        
        for line in lines {
            var itemTypes: [String: Int] = [:]
            let lineSize = line.count
            let rucksack1 = line.exploded()[0..<(lineSize/2)].joined()
            let rucksack2 = line.exploded()[(lineSize/2)..<lineSize].joined()
            
            for element in rucksack1 {
                if rucksack2.contains(element) {
                    itemTypes[String(element)] = table[String(element)]!
                    sum += table[String(element)]!
                    break
                }
            }
        }
        
        return sum.string
    }
    
    public override func part2() -> String {
        var sum = 0
        
        for rucksacks in lines.chunks(ofSize: 3) {
            let indices = rucksacks.indices
            for element in rucksacks[indices.lowerBound] {
                if rucksacks[indices.lowerBound + 1].contains(element) && rucksacks[indices.lowerBound + 2].contains(element) {
                    sum += table[String(element)]!
                    break
                }
            }
        }
        
        return sum.string
    }
}
