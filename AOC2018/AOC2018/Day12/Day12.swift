import Foundation

public final class Day12: Day {
    private let initialState: String
    private let rules: [String: String]
    
    public override init() {
        let input = Input().trimmedInputCharactersByNewlines()
        let ruleRegex = Regex(pattern: "^([.|#][.|#][.|#][.|#][.|#]) => (.|#)$")
        initialState = input.first!.components(separatedBy: .whitespaces).last!
        rules = input.dropFirst(2).reduce(into: [:]) { dict, line in
            let match = ruleRegex.matches(in: line)!
            dict[match[1]] = match[2]
        }
        super.init()
    }
    
    public override func part1() -> String {
        return String(potCountForGeneration(20))
    }
    
    public override func part2() -> String {
        return String(potCountForGeneration(50_000_000_000))
    }
    
    private func potCountForGeneration(_ generations: Int) -> Int {
        var state = Array(repeating: ".", count: 5) + initialState.exploded()
        
        var generationShift = 0
        var previousGeneration = 0
        var lastGeneration = 0
        var repetition = 0
        
        for generation in (1...generations) {
            var changeIndex: [Int: String] = [:]
            
            if state[(state.count-3)..<state.count].contains("#") {
                state.append(contentsOf: [".",".",".",".","."])
            }
            
            for i in state.indices {
                if let chain = state[safe: i..<(i+5)]?.joined() {
                    for (match, generation) in rules {
                        if match == chain {
                            changeIndex[i+2] = generation
                        }
                    }
                }
            }
            
            for (index, gen) in changeIndex {
                state[index] = gen
            }
            
            let potCount = state.enumerated().reduce(0) { seed, arg in
                seed + (arg.element == "#" ? arg.offset-5 : 0)
            }
            
            lastGeneration = generation
            if generationShift != 0 && generationShift == (potCount - previousGeneration) {
                generationShift = (potCount - previousGeneration)
                previousGeneration = potCount
                repetition += 1
                if repetition > 5 {
                    break
                }
            } else {
                generationShift = (potCount - previousGeneration)
                previousGeneration = potCount
            }
        }
        
        let potCount = state.enumerated().reduce(0) { seed, arg in
            seed + (arg.element == "#" ? arg.offset-5 : 0)
        }
        
        return potCount + (generations - lastGeneration) * generationShift

    }
}
