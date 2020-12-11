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
	public func firstWhile(from position: Position, along direction: Position, _ predicate: (Element.Element) -> Bool) -> Position {
		var nextPosition = position + direction
		while self[safe: nextPosition.y]?[safe: nextPosition.x] != nil {
			if let element = self[safe: nextPosition.y]?[safe: nextPosition.x], !predicate(element) {
				return nextPosition
			}
			nextPosition = nextPosition + direction
		}
		return nextPosition
	}
}
