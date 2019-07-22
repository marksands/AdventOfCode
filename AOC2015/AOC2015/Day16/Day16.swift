import Foundation
import AdventOfCode

public struct AuntSue {
    public let id: Int
    
    public let children: Int?
    public let cats: Int?
    public let samoyeds: Int?
    public let pomeranians: Int?
    public let akitas: Int?
    public let vizslas: Int?
    public let goldfish: Int?
    public let trees: Int?
    public let cars: Int?
    public let perfumes: Int?
}

public final class Day16: Day {
    private let sues: [AuntSue]
    
    public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
        let sueRegex = Regex(pattern: "^Sue (\\d+):")
        
        sues = input.map { line -> AuntSue in
            let sueMatch = sueRegex.matches(in: line)!
            
            let id = Int(sueMatch[1])!
            let rest = line.components(separatedBy: sueMatch[0]).last!
            
            let children = (Regex(pattern: "children: (\\d+)").matches(in: rest)?[1]).flatMap { Int(String($0)) }
            let cats = (Regex(pattern: "cats: (\\d+)").matches(in: rest)?[1]).flatMap { Int(String($0)) }
            let samoyeds = (Regex(pattern: "samoyeds: (\\d+)").matches(in: rest)?[1]).flatMap { Int(String($0)) }
            let pomeranians = (Regex(pattern: "pomeranians: (\\d+)").matches(in: rest)?[1]).flatMap { Int(String($0)) }
            let akitas = (Regex(pattern: "akitas: (\\d+)").matches(in: rest)?[1]).flatMap { Int(String($0)) }
            let vizslas = (Regex(pattern: "vizslas: (\\d+)").matches(in: rest)?[1]).flatMap { Int(String($0)) }
            let goldfish = (Regex(pattern: "goldfish: (\\d+)").matches(in: rest)?[1]).flatMap { Int(String($0)) }
            let trees = (Regex(pattern: "trees: (\\d+)").matches(in: rest)?[1]).flatMap { Int(String($0)) }
            let cars = (Regex(pattern: "cars: (\\d+)").matches(in: rest)?[1]).flatMap { Int(String($0)) }
            let perfumes = (Regex(pattern: "perfumes: (\\d+)").matches(in: rest)?[1]).flatMap { Int(String($0)) }
            
            return AuntSue(id: id, children: children, cats: cats, samoyeds: samoyeds, pomeranians: pomeranians, akitas: akitas, vizslas: vizslas, goldfish: goldfish, trees: trees, cars: cars, perfumes: perfumes)
        }
        
        super.init()
    }
    
    public override func part1() -> String {
        let auntSue = sues.first(where: { sue in
            return sue.children.map { $0 == 3 } ?? true &&
                sue.cats.map { $0 == 7 } ?? true &&
                sue.samoyeds.map { $0 == 2 } ?? true &&
                sue.pomeranians.map { $0 == 3 } ?? true &&
                sue.akitas.map { $0 == 0 } ?? true &&
                sue.vizslas.map { $0 == 0 } ?? true &&
                sue.goldfish.map { $0 == 5 } ?? true &&
                sue.trees.map { $0 == 3 } ?? true &&
                sue.cars.map { $0 == 2 } ?? true &&
                sue.perfumes.map { $0 == 1 } ?? true
        })!
        return "\(auntSue.id)"
    }
    
    public override func part2() -> String {
        let auntSue = sues.first(where: { sue in
            return sue.children.map { $0 == 3 } ?? true &&
                sue.cats.map { $0 > 7 } ?? true &&
                sue.samoyeds.map { $0 == 2 } ?? true &&
                sue.pomeranians.map { $0 < 3 } ?? true &&
                sue.akitas.map { $0 == 0 } ?? true &&
                sue.vizslas.map { $0 == 0 } ?? true &&
                sue.goldfish.map { $0 < 5 } ?? true &&
                sue.trees.map { $0 > 3 } ?? true &&
                sue.cars.map { $0 == 2 } ?? true &&
                sue.perfumes.map { $0 == 1 } ?? true
        })!
        return "\(auntSue.id)"
    }
}
