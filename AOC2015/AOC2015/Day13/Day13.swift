import Foundation
import AdventOfCode

public struct Person {
    public let name: String
    private let costs: [String: Int]
    
    public init(name: String, costs: [String: Int]) {
        self.name = name
        self.costs = costs
    }
    
    public func costSittingBy(_ peer: Person) -> Int {
        return costs[peer.name, default: 0]
    }
}

public final class Day13: Day {
    private var people: [Person]
    
    public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
        let regex = Regex(pattern: "^(\\w+) would (gain|lose) (\\d+) happiness units by sitting next to (\\w+).$")
        
        let items = input.map { line -> (String, [String: Int]) in
            let matches = regex.matches(in: line)!
            let cost = (matches[2] == "gain" ? 1 : -1) * Int(matches[3])!
            return (matches[1], [matches[4]: cost])
        }
        
        people = Dictionary(grouping: items, by: { $0.0 }).map { arg -> Person in
            let nameToCost = items.filter { $0.0 == arg.key }.reduce([String: Int]()) { $0.merging(with: $1.1) }
            return Person(name: arg.key, costs: nameToCost)
        }
        
        super.init()
    }
    
    public override func part1() -> String {
        let optimalPath = findRoute({ self.cost(of: $0) > self.cost(of: $1) })
        return "\(cost(of: optimalPath))"
    }
    
    private func cost(of arrangement: [Person]) -> Int {
        var cost = 0
        zip(arrangement.indices, arrangement).forEach { index, person in
            cost += person.costSittingBy(arrangement[circularly: index-1])
            cost += person.costSittingBy(arrangement[circularly: index+1])
        }
        return cost
    }
    
    public override func part2() -> String {
        let additionalSelf = Person(name: "Self", costs: people.reduce([String:Int]()) { $0.merging(with: [$1.name: 0]) })
        people.append(additionalSelf)
        
        let optimalPath = findRoute({ self.cost(of: $0) > self.cost(of: $1) })
        return "\(cost(of: optimalPath))"
    }
    
    private func findRoute(_ sortOrder: @escaping ([Person], [Person]) -> Bool) -> [Person] {
        var possibleNodes = PriorityQueue<[Person]>(sort: sortOrder)
        let maxNodes = people.lazy.map({ $0.name }).unique().count
        
        for person in people {
            var queue = [[person]]
            
            while queue.count > 0 {
                let path = queue.popLast()!
                
                if path.count == maxNodes {
                    possibleNodes.enqueue(path)
                } else {
                    for neighbor in neighbors(of: path) {
                        queue.append(path + [neighbor])
                    }
                }
            }
        }
        
        return possibleNodes.dequeue() ?? []
    }
    
    public func neighbors(of route: [Person]) -> [Person] {
        return people.filter { person in !route.contains(where: { $0.name == person.name }) }
    }
}
