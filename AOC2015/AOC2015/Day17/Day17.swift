import Foundation
import AdventOfCode

public final class Day17: Day {
    public struct Container: Equatable, Hashable {
        public let liter: Int
        
        public init(liter: Int) {
            self.liter = liter
        }
    }
    
    public let containers: [Container]

    public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
        containers = input.compactMap(Int.init).map(Container.init)
        super.init()
    }
    
    public override func part1() -> String {
        let solutions = containers
            .combinations(of: (0...containers.count))
            .filter { $0.map({ $0.liter }).sum() == 150 }
        return "\(solutions.count)"
    }
    
    public override func part2() -> String {
        let solutions = containers
            .combinations(of: (0...containers.count))
            .filter { $0.map({ $0.liter }).sum() == 150 }
        
        let minContainers = solutions.min { $0.count < $1.count }!
        let minimumSolutions = solutions.filter { $0.count == minContainers.count }
        
        return "\(minimumSolutions.count)"
    }
}

