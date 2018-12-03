import UIKit

extension CGRect {
    public func intersectingPoints(_ rect2: CGRect) -> [CGPoint] {
        guard self.intersects(rect2) else { return [] }
        let intersection = self.intersection(rect2)
        return (Int(intersection.origin.x)..<Int(intersection.origin.x + intersection.size.width)).flatMap { x in
            (Int(intersection.origin.y)..<Int(intersection.origin.y + intersection.size.height)).map { y in
                return CGPoint(x: x, y: y)
            }
        }
    }
}
