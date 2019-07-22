import Foundation
import AdventOfCode

public struct Ingredient {
    public let name: String
    public let capacity: Int
    public let durability: Int
    public let flavor: Int
    public let texture: Int
    public let calories: Int
}

public final class Day15: Day {
    public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
        super.init()

        let regex = Regex(pattern: "^(\\w+): capacity (-?\\d+), durability (-?\\d+), flavor (-?\\d+), texture (-?\\d+), calories (-?\\d+)$")
        
        let ingredients = input.map { line -> Ingredient in
            let matches = regex.matches(in: line)!
            return Ingredient(name: matches[1], capacity: Int(matches[2])!, durability: Int(matches[3])!, flavor: Int(matches[4])!, texture: Int(matches[5])!, calories: Int(matches[6])!)
        }

        print(ingredients)
    }
    
    public override func part1() -> String {
        //[1, 2].partit
        
        return ""
    }
    
    public override func part2() -> String {
        return ""
    }
}
