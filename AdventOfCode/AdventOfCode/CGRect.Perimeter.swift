import UIKit.UIGeometry

extension CGRect {
	/// Returns an array of points containing only the perimeter of the `CGRect`.
    public func perimeter() -> [CGPoint] {
        let minX = Int(self.minX)
        let minY = Int(self.minY)
        let width = Int(self.width)
        let height = Int(self.height)
        
        return (minY...height).map({ CGPoint(x: minX, y: $0) }) +
            (minY...height).map({ CGPoint(x: width, y: $0) }) +
            (minX...width).map({ CGPoint(x: $0, y: minY) }) +
            (minX...width).map({ CGPoint(x: $0, y: height) })
    }
}
