import Foundation

public final class Day6: Day {
    private let grid: [[String]]
    private let boundary: [CGPoint]
    private var ownedPoints: [String: [CGPoint]] = [:]
    
    private let points: [CGPoint] = Input().trimmedInputCharactersByNewlines()
        .map { $0.components(separatedBy: ", ").compactMap(Int.init) }
        .map { CGPoint(x: $0.first!, y: $0.last!) }
    
    public override init() {
        let width = Int(points.reduce(CGFloat.leastNormalMagnitude) { max($0, $1.x) })
        let height = Int(points.reduce(CGFloat.leastNormalMagnitude) { max($0, $1.y) })
        
        grid = (0...height).map { _ in
            (0...width).map { _ in
                return "."
            }
        }
        
        let columnBoundary = (0...height).map({ CGPoint(x: 0, y: $0) }) + (0...height).map({ CGPoint(x: width, y: $0 ) })
        let rowBoundary = (0...width).map({ CGPoint(x: $0, y: 0) }) + (0...width).map({ CGPoint(x: $0, y: height) })
        boundary = columnBoundary + rowBoundary
        
        super.init()
    }

    public override func part1() -> String {
        return "\(areaOfLargestFiniteRegion())"
    }
    
    public override func part2() -> String {
        return "\(areaOfSafeRegion())"
    }
    
    public func manhattenDistance(from p1: CGPoint, to p2: CGPoint) -> Int {
        return abs(Int(p1.y - p2.y)) + abs(Int(p1.x - p2.x))
    }
    
    
    private func keyForPoint(_ point: CGPoint) -> String? {
        let possibleKeys = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return points.firstIndex(of: point).map { possibleKeys.exploded()[$0] }
    }
    
    public func areaOfLargestFiniteRegion() -> Int {
        let remainingPoints = zip(grid.indices, grid).flatMap { arg in
            zip(arg.1.indices, arg.1).map { arg2 -> CGPoint in
                CGPoint(x: arg2.0, y: arg.0)
            }
        }.filter { !points.contains($0) }
        
        remainingPoints.forEach { point in
            let scores = points.map { manhattenDistance(from: point, to: $0) }
            if scores.countElements()[scores.min()!] == 1 {
                let firstPoint = points.sorted { manhattenDistance(from: point, to: $0) < manhattenDistance(from: point, to: $1) }.first!
                ownedPoints[keyForPoint(firstPoint)!, default: []].append(point)
            }
        }
        
        boundary.forEach { point in
            if let infiniteRegionKey = ownedPoints.first(where: { $0.value.contains(point) })?.key {
                ownedPoints.removeValue(forKey: infiniteRegionKey)
            }
        }
        
        let maxKey = ownedPoints.max(by: { $0.value.count < $1.value.count })!.key
        return ownedPoints[maxKey]!.count + 1
    }
    
    public func areaOfSafeRegion() -> Int {
        let remainingPoints = zip(grid.indices, grid).flatMap { arg in
            zip(arg.1.indices, arg.1).map { arg2 -> CGPoint in
                CGPoint(x: arg2.0, y: arg.0)
            }
        }.filter { !points.contains($0) }
        
        return (points + remainingPoints).reduce(0) { seed, point in
            if points.reduce(0, { $0 + manhattenDistance(from: point, to: $1) }) < 10000 {
                return seed + 1
            }
            return seed
        }
    }
}
