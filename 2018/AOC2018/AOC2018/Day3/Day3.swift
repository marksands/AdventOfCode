import Foundation
import CoreGraphics.CGGeometry

public final class Day3: Day {
    private let rects: [CGRect]
    
    public override init() {
        let rows = Input().trimmedInputCharactersByNewlines()
        let regex = Regex(pattern: "^\\#(\\d+) @ (\\d+),(\\d+): (\\d+)x(\\d+)$")
        rects = rows.compactMap {
            guard let match = regex.matches(in: $0) else { return nil }
            let values = match.matches.dropFirst().compactMap(Int.init)
            return CGRect(x: values[1], y: values[2], width: values[3], height: values[4])
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
                rect1.intersectingPoints(rect2).map({ $0.debugDescription })
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
