import Foundation
import AdventOfCode

public final class Day2: Day {
    private let prismDimensions: [[Int]]
    
    public override init() {
        let regex = Regex(pattern: "^(\\d+)x(\\d+)x(\\d+)$")
        prismDimensions = Input().trimmedInputCharactersByNewlines()
            .compactMap { regex.matches(in: $0)?.matches.compactMap(Int.init) }
        super.init()
    }
    
    public override func part1() -> String {
        let feet = prismDimensions.reduce(into: 0) { result, prism in
            result += squareFeetOfPrismWithSlack(prism)
        }
        return "\(feet)"
    }
    
    public override func part2() -> String {
        let feet = prismDimensions.reduce(into: 0) { result, prism in
            result += (smallestParemter(prism) + ribbon(prism))
        }
        return "\(feet)"
    }
    
    private func squareFeetOfPrismWithSlack(_ dimensions: [Int]) -> Int {
        let values = [dimensions[0] * dimensions[1], dimensions[1] * dimensions[2], dimensions[0] * dimensions[2]]
        return values.map { $0 * 2 }.sum() + values.min()!
    }
    
    private func smallestParemter(_ dimensions: [Int]) -> Int {
        let sums = [dimensions[0] + dimensions[1], dimensions[1] + dimensions[2], dimensions[0] + dimensions[2]]
        return sums.min()! * 2
    }

    private func ribbon(_ dimensions: [Int]) -> Int {
        return dimensions.reduce(1) { $0 * $1 }
    }
}
