public struct Position: Comparable {
    public var x: Int
    public var y: Int
    
    public static func < (lhs: Position, rhs: Position) -> Bool {
        return (lhs.y, lhs.x) < (rhs.y, rhs.x)
    }
}
