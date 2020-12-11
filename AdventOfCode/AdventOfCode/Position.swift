public struct Position: Equatable, Hashable {
    public var x: Int
    public var y: Int
    public var z: Int
    public var w: Int
    
    public init(x: Int, y: Int, z: Int = 0, w: Int = 0) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }
    
    public func north() -> Position {
        return Position(x: x, y: y - 1)
    }

    public func east() -> Position {
        return Position(x: x + 1, y: y)
    }

    public func south() -> Position {
        return Position(x: x, y: y + 1)
    }

    public func west() -> Position {
        return Position(x: x - 1, y: y)
    }
        
    public func surrounding() -> [Position] {
        return [north().west(), north(), north().east(),
                west(), east(),
                south().west(), south(), south().east()]
    }

	public func adjacent() -> [Position] {
		return [north(), west(), east(), south()]
	}
    
    public func manhattanDistance(to p2: Position) -> Int {
        return abs(Int(w - p2.w)) + abs(Int(z - p2.z)) + abs(Int(y - p2.y)) + abs(Int(x - p2.x))
    }
    
    public static var zero: Position {
        return Position(x: 0, y: 0)
    }

	public static var surroundingDirections: [Position] {
		[Position.zero.north().west(), Position.zero.north(), Position.zero.north().east(),
		 Position.zero.west(), Position.zero.east(),
		 Position.zero.south().west(), Position.zero.south(), Position.zero.south().east()]
	}
}

public func +(lhs: Position, rhs: Position) -> Position {
    return Position(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z, w: lhs.w + rhs.w)
}

extension Position: Comparable {
    public static func < (lhs: Position, rhs: Position) -> Bool {
        return (lhs.y, lhs.x) < (rhs.y, rhs.x)
    }
}

extension Array where Element: Collection, Element.Index == Int {
	/// traverse along a direction for a 2d-matrix until the predicate no long resolves as true
	///
	/// - Parameters:
	/// 	- position: The starting position to begin traversal.
	/// 	- direction: The direction to move along the axis. Can be 1 of 8. (see `Position.surroundingDirections`)
	///		- predicate: The condition to be evaluated to continue traversal. When the predicate resolves as false, the
	///			 traversal ends and the current position is returned.
	///
	///	- Returns: Once the predicate evaluates to false, the current position is returned if it lies within the bounds of the matrix. Otherwise nil.
	///
	public func firstWhile(from position: Position, along direction: Position, _ predicate: (Element.Element) -> Bool) -> Position? {
		var nextPosition = position + direction
		while let element = self[safe: nextPosition.y]?[safe: nextPosition.x] {
			if !predicate(element) {
				return nextPosition
			}
			nextPosition = nextPosition + direction
		}
		return nil
	}
}

extension Array {
	/// traverse along a direction for a 2d-matrix that has been flattened as a 1-dimensional matrix until the predicate no long resolves as true
	///
	/// - Parameters:
	/// 	- position: The starting position to begin traversal.
	/// 	- direction: The direction to move along the axis. Can be 1 of 8. (see `Position.surroundingDirections`)
	///		- width: the width of the matrix. Required since there is no nested array to calculate the width.
	///		- predicate: The condition to be evaluated to continue traversal. When the predicate resolves as false, the
	///			 traversal ends and the current position is returned.
	///
	///	- Returns: Once the predicate evaluates to false, the current position is returned if it lies within the bounds of the matrix. Otherwise nil.
	///
	public func firstWhile(from position: Position, along direction: Position, width: Int, _ predicate: (Element) -> Bool) -> Position? {
		var nextPosition = position + direction
		while let element = element(from: nextPosition, width: width) {
			if !predicate(element) {
				return nextPosition
			}
			nextPosition = nextPosition + direction
		}
		return nil
	}

	/// Returns an element indexed by a 2D position within a 1-dimensional array, if it exists. Otherwise nil.
	public func element(from position: Position, width: Int) -> Element? {
		guard position.x >= 0, position.x < width, position.y >= 0 else { return nil }
		return self[safe: width * position.y + position.x]
	}
}

extension Dictionary where Key == Position {
	/// traverse along a direction for a 2d-matrix that has been converted as a dictionary for fast lookup, until the predicate
	/// no long resolves as true
	///
	/// - Parameters:
	/// 	- position: The starting position to begin traversal.
	/// 	- direction: The direction to move along the axis. Can be 1 of 8. (see `Position.surroundingDirections`)
	///		- predicate: The condition to be evaluated to continue traversal. When the predicate resolves as false, the
	///			 traversal ends and the current position is returned.
	///
	///	- Returns: Once the predicate evaluates to false, the current position is returned if it lies within the bounds of the matrix. Otherwise nil.
	///
	public func firstWhile(from position: Position, along direction: Position, _ predicate: (Value) -> Bool) -> Position? {
		var nextPosition = position + direction
		while let element = self[nextPosition] {
			if !predicate(element) {
				return nextPosition
			}
			nextPosition = nextPosition + direction
		}
		return nil
	}}
