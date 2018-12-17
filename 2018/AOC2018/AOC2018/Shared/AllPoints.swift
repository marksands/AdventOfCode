import UIKit.UIGeometry

extension CGRect {
    public func allPoints() -> [CGPoint] {
        return (Int(minY)...Int(height)).flatMap { y in
            (Int(minX)...Int(width)).map { x in
                return CGPoint(x: x, y: y)
            }
        }
    }

    public func allPositionsMatrix() -> [[Position]] {
        return (Int(minY)...Int(height)).map { y in
            (Int(minX)...Int(width)).map { x in
                return Position(x: x, y: y)
            }
        }
    }
}
