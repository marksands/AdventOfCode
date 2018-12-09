import UIKit.UIGeometry

extension CGRect {
    public func allPoints() -> [CGPoint] {
        return (Int(minY)...Int(height)).flatMap { y in
            (Int(minX)...Int(width)).map { x in
                return CGPoint(x: x, y: y)
            }
        }
    }
}
