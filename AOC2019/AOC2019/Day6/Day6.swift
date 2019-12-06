import Foundation
import AdventOfCode

public final class Day6: Day {
    private var dependencies: [String: [String]] = [:]
    
    public override init() {
        super.init()

        let regex = Regex(pattern: "^(\\w+)\\)(\\w+)$")
        Input().trimmedInputCharactersByNewlines()
            .map { regex.matches(in: $0)! }
            .forEach {
                dependencies[$0[1], default: []].append($0[2])
        }
    }
    
    public override func part1() -> String {
        let orbits = dependencies.keys.reduce(into: 0) { seed, key in
            seed += countDependencies(key)
        }
        return "\(orbits)"
    }
    
    private func countDependencies(_ key: String) -> Int {
        let orbits = dependencies[key] ?? []
        return orbits.count + orbits.reduce(into: 0) { $0 += self.countDependencies($1) }
    }
    
    public override func part2() -> String {
        let youOrbit = Array(dependencies.filter { $0.value.contains("YOU") }.keys)
        let sanOrbit = Array(dependencies.filter { $0.value.contains("SAN") }.keys)
        
        let result = findShortestPath(youOrbit[0], sanOrbit[0]).count
        return String(result)
    }
    
    private func findShortestPath(_ youOrbit: String, _ sanOrbit: String) -> [String] {
        var possiblePaths = PriorityQueue<[String]>(sort: { $0.count < $1.count })
        
        let neighborsOfYou = neighbors(of: [youOrbit])
                
        for key in neighborsOfYou {
            var queue = PriorityQueue<[String]>(sort: { $0.count < $1.count })
            queue.enqueue([key])
        
            while queue.count > 0 {
                let path = queue.dequeue()!
                
                if path.last == sanOrbit {
                    possiblePaths.enqueue(path)
                }
                
                for neighbor in neighbors(of: path) {
                    queue.enqueue(path + [neighbor])
                }
            }
        }
        
        return possiblePaths.dequeue() ?? []
    }
    
    private func neighbors(of path: [String]) -> [String] {
        guard let lastNode = path.last else { return [] }
        let some = dependencies[lastNode, default: []]
        let others = Array(dependencies.filter { $0.value.contains(lastNode) }.keys)
        let newNeighbors = (some + others).unique()
        
        return newNeighbors.filter { !path.contains($0) }
    }
}
