import Foundation

public final class Day6: Day {
    private let points: [CGPoint] = Input().trimmedInputCharactersByNewlines()
        .map { $0.components(separatedBy: ", ").compactMap(Int.init) }
        .map { CGPoint(x: $0.first!, y: $0.last!) }
    
    public override func part1() -> String {
        return "\(areaOfLargestFiniteRegion())"
    }
    
    public override func part2() -> String {
        return "\(areaOfSafeRegion())"
    }
    
    private func boundingRect() -> CGRect {
        let minX = points.map { $0.x }.min()!
        let minY = points.map { $0.y }.min()!
        let width = points.map { $0.x }.max()!
        let height = points.map { $0.y }.max()!
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
    
    private func manhattenDistance(from p1: CGPoint, to p2: CGPoint) -> Int {
        return abs(Int(p1.y - p2.y)) + abs(Int(p1.x - p2.x))
    }
    
    private func areaOfLargestFiniteRegion() -> Int {
        var ownedPoints: [String: [CGPoint]] = [:]

        boundingRect().allPoints().forEach { point in
            let scores = points.map { manhattenDistance(from: point, to: $0) }.sorted()
            if scores[0] != scores[1] {
                let firstPoint = points.min(by: { manhattenDistance(from: point, to: $0) < manhattenDistance(from: point, to: $1) })!
                ownedPoints[firstPoint.debugDescription, default: []].append(point)
            }
        }
        
        boundingRect().perimeter().forEach { point in
            if let infiniteRegionKey = ownedPoints.first(where: { $0.value.contains(point) })?.key {
                ownedPoints.removeValue(forKey: infiniteRegionKey)
            }
        }
        
        let maxKey = ownedPoints.max(by: { $0.value.count < $1.value.count })!.key
        return ownedPoints[maxKey]!.count
    }
    
    private func areaOfSafeRegion() -> Int {
        let remainingPoints = boundingRect().allPoints().filter { !points.contains($0) }

        return (points + remainingPoints).reduce(0) { seed, point in
            if points.reduce(0, { $0 + manhattenDistance(from: point, to: $1) }) < 10000 {
                return seed + 1
            }
            return seed
        }
    }
}
