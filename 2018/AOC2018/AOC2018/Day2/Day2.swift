import Foundation

public final class Day2: Day {
    let boxIds = Input().inputCharactersByNewlines()
    
    public override func part1() -> String {
        return "\(part1Result())"
    }
    
    public override func part2() -> String {
        return part2Result()
    }
    
    private func part1Result() -> Int {
        let countedSubstrings = boxIds.map { $0.countElements().values }
        return countedSubstrings.count(where: { $0.contains(2) }) * countedSubstrings.count(where: { $0.contains(3) })
    }
    
    private func part2Result() -> String {
        return boxIds
            .compactMap { id in boxIds.first(where: { distance(from: id, to: $0) == 1 }).map({ (id, $0) }) }
            .map { intersection(of: $0, and: $1) }.first ?? ""
    }
}
