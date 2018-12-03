import UIKit

public final class Day3: Day {
    private let rects: [CGRect]
    
    public override init() {
        let rows = Input().trimmedInputCharactersByNewlines()
        rects = rows.map {
            let claim = $0.components(separatedBy: .whitespaces)
            let offset = claim[2].replacingOccurrences(of: ":", with: "").components(separatedBy: ",").compactMap(Int.init)
            let origin = CGPoint(x: offset[0], y: offset[1])
            let area = claim[3].components(separatedBy: "x").compactMap(Int.init)
            let size = CGSize(width: area[0], height: area[1])
            return CGRect(origin: origin, size: size)
        }
    }
    
    public override func part1() -> String {
        return "\(part1Result())"
    }
    
    public override func part2() -> String {
        return "\(part2Result())"
    }
    
    private func part1Result() -> Int {
        return rects.flatMap { rect1 in
            rects.filter { $0 != rect1 }.flatMap { rect2 in
                rect1.intersectingPoints(rect2).map(NSValue.init)
            }
        }.unique().count
    }
    
    private func part2Result() -> Int {
        return rects
            .map { r in rects.filter({ $0 != r }).first(where: { $0.intersects(r) }) }
            .firstIndex(where: { $0 == nil })
            .map { $0 + 1 } ?? 0
    }
}
