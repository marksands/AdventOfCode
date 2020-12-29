#if os(iOS) || targetEnvironment(macCatalyst)
import UIKit

extension CGRect {
	
	/// Returns a nested array of `Position`s row-column wise
	///
	///	For example:
	///
	///		let r = CGRect(x: 0, y: 0, width: 5, height: 5)
	///		r.allPositionsMatrix()
	///
	///		// [[ (0, 0), (1, 0), (2, 0), (3, 0), (4, 0), (5, 0) ],
	///		// ...
	///		//  [ (0, 5), (1, 5), (2, 5), (3, 5), (4, 5), (5, 5) ]]
	public func allPositionsMatrix() -> [[Position]] {
		return (Int(minY)...Int(height)).map { y in
			(Int(minX)...Int(width)).map { x in
				return Position(x: x, y: y)
			}
		}
	}
	
	
}
#endif
