import Foundation

struct Rule {
    let l1: String
    let l2: String
    let c: String
    let r1: String
    let r2: String
    
    var match: String {
        return l1 + l2 + c + r1 + r2
    }
    
    let generation: String
}

public final class Day12: Day {
    public override func part1() -> String {
        return super.part1()
    }
    
    public override func part2() -> String {
        let ruleRegex = Regex(pattern: "^(.|#)(.|#)(.|#)(.|#)(.|#) => (.|#)$")
        
        let input = """
.#### => .
.###. => .
#.... => .
##### => .
..### => #
####. => #
..#.. => .
###.# => .
..##. => .
#.##. => #
#.#.. => .
##... => .
..#.# => #
#.### => #
.#..# => .
#...# => #
.##.# => #
.#.#. => #
#..#. => #
###.. => #
...#. => .
.#.## => #
.##.. => .
#..## => .
##.## => .
.#... => #
#.#.# => .
##..# => .
....# => .
..... => .
...## => #
##.#. => .
"""
        
        // prepend -20
        // append +40
        var state = "#.#..#.##.#..#.#..##.######...####.........#..##...####.#.###......#.#.##..#.#.###.#..#.#.####....##".exploded()
        
        let rules = input.components(separatedBy: .newlines).map { line -> Rule in
            let match = ruleRegex.matches(in: line)!
            return Rule(l1: match[1], l2: match[2], c: match[3], r1: match[4], r2: match[5], generation: match[6])
        }
        
        var pivotIndex = 0
        
        (0..<5000).forEach { generation in
            var changeIndex: [Int: String] = [:]
            
            if state.last == "#" || state[state.count-2] == "#" || state[state.count-3] == "#" {
                state.append(contentsOf: [".",".",".",".","."])
            }
            
            if state.first == "#" {
                state.insert(contentsOf: [".",".",".",".","."], at: 0)
                pivotIndex += 5
            }
            
            for i in stride(from: 0, to: state.count, by: 1) {
                guard i+4 < state.count else { continue }
                let markup = [state[i], state[i+1], state[i+2], state[i+3], state[i+4]].joined()
                rules.forEach { rule in
                    if rule.match == markup {
                        changeIndex[i+2] = rule.generation
                    }
                }
            }
            
            for (index, gen) in changeIndex {
                state[index] = gen
            }
            
            let prePotCount = state.prefix(pivotIndex).reversed().enumerated().reduce(0) { seed, arg in
                seed + (arg.element == "#" ? -arg.offset : 0)
            }
            
            let subPots = state.dropFirst(pivotIndex)
            let potCount = subPots.enumerated().reduce(0) { seed, arg in
                seed + (arg.element == "#" ? arg.offset : 0)
            }
            
            let count = prePotCount + potCount
            
            print("G: \(generation) - \(count) [\(potCount) - \(prePotCount)]")
        }
        
        //print(state.joined())
        //
        //let subPots = state.dropFirst(20)
        //let potCount = subPots.enumerated().reduce(0) { seed, arg in
        //    seed + (arg.element == "#" ? arg.offset : 0)
        //}
        //print(subPots)
        //print(potCount) // 1991
        
        return "TBD"
    }
}

// generation 5000, noticed a pattern of adding 22
// 110511 + ((50000000000 - 5000) * 22)
// answer for part2: 1100000000511
