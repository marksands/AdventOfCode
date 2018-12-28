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
    
    public func manhattenDistance(to p2: Position) -> Int {
        return abs(Int(w - p2.w)) + abs(Int(z - p2.z)) + abs(Int(y - p2.y)) + abs(Int(x - p2.x))
    }
    
    public static var zero: Position {
        return Position(x: 0, y: 0)
    }
}

extension Position: Comparable {
    public static func < (lhs: Position, rhs: Position) -> Bool {
        return (lhs.y, lhs.x) < (rhs.y, rhs.x)
    }
}
