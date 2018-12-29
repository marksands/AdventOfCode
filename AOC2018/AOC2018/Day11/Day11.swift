import Foundation

public final class Day11: Day {
    private let serialNumber = 7511

    public override func part1() -> String {
        let maxPoint = validCoordinates().max(by: { regionPowerLevel(at: $0) < regionPowerLevel(at: $1) })!
        return "\(Int(maxPoint.x)),\(Int(maxPoint.y))"
    }
    
    public override func part2() -> String {
        let (point, size) = (13..<14).map { size -> (CGPoint, Int) in
            return (validCoordinates(forMaxSize: size)
                .max(by: { regionPowerLevel(at: $0, size: size) < regionPowerLevel(at: $1, size: size) })!, size)
        }.max(by: { regionPowerLevel(at: $0.0) < regionPowerLevel(at: $1.0) })!
        
        return "\(Int(point.x)),\(Int(point.y)),\(size)"
    }
    
    private func validCoordinates(forMaxSize size: Int = 3) -> [CGPoint] {
        return CGRect(x: 1, y: 1, width: 300, height: 300)
            .allPoints()
            .filter { $0.x <= CGFloat(301 - size) && $0.y <= CGFloat(301 - size) }
    }
    
    private func regionPowerLevel(at point: CGPoint, size: Int = 3) -> Int {
        return (Int(point.x)..<(Int(point.x)+size)).flatMap({ x in
            (Int(point.y)..<(Int(point.y)+size)).map({ y in
                return value(for: CGPoint(x: x, y: y))
            })
        }).sum()
    }
    
    private func value(for coordinate: CGPoint) -> Int {
        let rackId = Int(coordinate.x) + 10
        var powerLevel = rackId * Int(coordinate.y)
        powerLevel += serialNumber
        powerLevel *= rackId
        let hundredsDigit = ((powerLevel / 100) % 10)
        return hundredsDigit - 5
    }
}
