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
    private let ingredients: [Ingredient]
    
    public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
        let regex = Regex(pattern: "^(\\w+): capacity (-?\\d+), durability (-?\\d+), flavor (-?\\d+), texture (-?\\d+), calories (-?\\d+)$")
        
        ingredients = input.map { line -> Ingredient in
            let matches = regex.matches(in: line)!
            return Ingredient(name: matches[1], capacity: Int(matches[2])!, durability: Int(matches[3])!, flavor: Int(matches[4])!, texture: Int(matches[5])!, calories: Int(matches[6])!)
        }
        
        super.init()
    }
    
    // TODO: optimize
    public override func part1() -> String {
        let scores = IntegerPartitionSum(sum: 100)
            .lazy
            .filter({ $0.count == self.ingredients.count })
            .flatMap({ ingredientPartition -> [Int] in
                return Array(ingredientPartition.permutations()).map { permuation -> Int in
                    let formulas = zip(self.ingredients, permuation)
                        .map { [$0.capacity * $1, $0.durability * $1, $0.flavor * $1, $0.texture * $1] }
                    return
                        max(0, formulas.reduce(0) { $0 + $1[0] }) *
                            max(0, formulas.reduce(0) { $0 + $1[1] }) *
                            max(0, formulas.reduce(0) { $0 + $1[2] }) *
                            max(0, formulas.reduce(0) { $0 + $1[3] })
                }
            })
        
        return "\(scores.max()!)"
    }
    
    // TODO: optimize
    public override func part2() -> String {
        let scores = IntegerPartitionSum(sum: 100)
            .lazy
            .filter({ $0.count == self.ingredients.count })
            .flatMap({ ingredientPartition -> [Int] in
                return Array(ingredientPartition.permutations()).compactMap { permuation -> Int? in
                    let formulas = zip(self.ingredients, permuation)
                        .map { [$0.capacity * $1, $0.durability * $1, $0.flavor * $1, $0.texture * $1, $0.calories * $1] }
                    
                    guard formulas.reduce(0, { $0 + $1[4] }) == 500 else { return nil }
                    
                    return
                        max(0, formulas.reduce(0) { $0 + $1[0] }) *
                            max(0, formulas.reduce(0) { $0 + $1[1] }) *
                            max(0, formulas.reduce(0) { $0 + $1[2] }) *
                            max(0, formulas.reduce(0) { $0 + $1[3] })
                }
            })
        
        return "\(scores.max()!)"
    }
}
