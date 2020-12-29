#if os(iOS) || targetEnvironment(macCatalyst)
import UIKit

extension CGRect {

	/// Returns an array of the 4 corners of the `CGRect` as `Position`s.
	public func corners() -> [Position] {
		return [
			Position(x: Int(minX), y: Int(minY)),
			Position(x: Int(maxX), y: Int(minY)),
			Position(x: Int(maxX), y: Int(maxY)),
			Position(x: Int(minX), y: Int(maxY))
		]
	}
}
#endif
