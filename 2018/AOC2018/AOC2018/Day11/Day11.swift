import Foundation

public final class Day11: Day {
    private let serialNumber = 7511

    public override func part1() -> String {
        var maxPoint = CGPoint.zero
        var maxValue = 0
        
        (1...300).forEach { x in
            (1...300).forEach { y in
                let point = CGPoint(x: x, y: y)
                if let value = powerLevelForRegionAtCoord(point), value > maxValue {
                    maxValue = value
                    maxPoint = point
                }
            }
        }
        
        return "\(Int(maxPoint.x)),\(Int(maxPoint.y))"
    }
    
    public override func part2() -> String {
        var maxPoint = CGPoint.zero
        var maxValue = 0
        var maxSize = 3
        
        (13..<14).forEach { size in
            (1...300).forEach { x in
                (1...300).forEach { y in
                    let point = CGPoint(x: x, y: y)
                    if let value = powerLevelForRegionAtCoord(point, size: size), value > maxValue {
                        maxValue = value
                        maxPoint = point
                        maxSize = size
                    }
                }
            }
        }
        
        return "\(Int(maxPoint.x)),\(Int(maxPoint.y)),\(maxSize)"
    }
    
    private func powerLevelForRegionAtCoord(_ point: CGPoint, size: Int = 3) -> Int? {
        if point.x <= CGFloat(301 - size) && point.y <= CGFloat(301 - size) {
            return (Int(point.x)..<(Int(point.x)+size)).flatMap({ x in
                (Int(point.y)..<(Int(point.y)+size)).map({ y in
                    return value(for: CGPoint(x: x, y: y))
                })
            }).sum()
        } else {
            return nil
        }
    }
    
    private func value(for coordinate: CGPoint) -> Int {
        let rackId = Double(coordinate.x + 10)
        var powerLevel = Double(rackId * Double(coordinate.y))
        powerLevel += Double(serialNumber)
        powerLevel *= rackId
        let hundredsDigit = ceil(log10(powerLevel)) >= 3 ? floor(powerLevel.truncatingRemainder(dividingBy: 1000) / 100) : 0
        return Int(hundredsDigit) - 5
    }
}
