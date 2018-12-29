import CoreGraphics.CGGeometry

extension CGRect {
    public func intersectingPoints(_ rect2: CGRect) -> [CGPoint] {
        guard self.intersects(rect2) else { return [] }
        let intersection = self.intersection(rect2)
        return (Int(intersection.minX)..<Int(intersection.maxX)).flatMap { x in
            (Int(intersection.minY)..<Int(intersection.maxY)).map { y in
                return CGPoint(x: x, y: y)
            }
        }
    }
}
