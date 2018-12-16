public struct Position: Equatable, Hashable {
    public var x: Int
    public var y: Int
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
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
}

extension Position: Comparable {
    public static func < (lhs: Position, rhs: Position) -> Bool {
        return (lhs.y, lhs.x) < (rhs.y, rhs.x)
    }
}
