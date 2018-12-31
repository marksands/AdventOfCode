import Foundation
import AdventOfCode

public final class Day9: Day {
    struct Route: Hashable {
        let departure: String
        let arrival: String
        let distance: Int
    }
    
    private let routes: [Route]
    
    public override init() {
        let regex = Regex(pattern: "^(\\w+) to (\\w+) = (\\d+)$")
        routes = Input().trimmedInputCharactersByNewlines().flatMap { line -> [Route] in
            let matches = regex.matches(in: line)!.matches
            return [
                Route(departure: matches[1], arrival: matches[2], distance: Int(matches[3])!),
                Route(departure: matches[2], arrival: matches[1], distance: Int(matches[3])!)
            ]
        }
        super.init()
    }
    
    public override func part1() -> String {
        return String(findShortestRoute().map { $0.distance }.sum())
    }
    
    public override func part2() -> String {
        return String(findLongestRoute().map { $0.distance }.sum())
    }
    
    private func findShortestRoute() -> [Route] {
        return findRoute(sortOrder: { $0.map({ $0.distance }).sum() < $1.map({ $0.distance }).sum() })
    }
    
    private func findLongestRoute() -> [Route] {
        return findRoute(sortOrder: { $0.map({ $0.distance }).sum() > $1.map({ $0.distance }).sum() })
    }
    
    private func findRoute(sortOrder: @escaping ([Route], [Route]) -> Bool) -> [Route] {
        var possibleRoutes: PriorityQueue<[Route]> = PriorityQueue<[Route]>(sort: sortOrder)
        let allDestinations = routes.flatMap { [$0.departure, $0.arrival] }.unique().count
        
        for route in routes {
            var queue = PriorityQueue<[Route]>(sort: sortOrder)
            queue.enqueue([route])
            
            while queue.count > 0 {
                let path = queue.dequeue()!
                
                if path.count == allDestinations - 1 {
                    possibleRoutes.enqueue(path)
                }
                
                for neighbor in neighbors(of: path) {
                    queue.enqueue(path + [neighbor])
                }
            }
        }
        return possibleRoutes.dequeue() ?? []
    }
    
    private func neighbors(of route: [Route]) -> [Route] {
        return routes.filter {
            let existingCities = route.flatMap { [$0.departure, $0.arrival] }
            return !(existingCities.contains($0.arrival) && existingCities.contains($0.departure))
        }.filter { $0.departure == route.last?.arrival }
    }
}
