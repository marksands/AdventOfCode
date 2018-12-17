import Foundation

public enum TileType: String {
    case water = "~"
    case flowing = "|"
    case sand = "."
    case clay = "#"
}

public class Tile {
    public var tileType: TileType
    public let position: Position
    
    public init(tileType: TileType, position: Position) {
        self.tileType = tileType
        self.position = position
    }
}

public final class Day17: Day {
    private let claySpaces: [Position]
    private var desert: [[Tile]] = []
    
    public init(input: String = Input().trimmedRawInput()) {
        let xRegex = Regex.init(pattern: "^x=(\\d+), y=(\\d+)..(\\d+)$")
        let yRegex = Regex.init(pattern: "^y=(\\d+), x=(\\d+)..(\\d+)$")
        claySpaces = input.components(separatedBy: .newlines).flatMap { claySpace -> [Position] in
            if let matches = xRegex.matches(in: claySpace)?.matches.compactMap(Int.init) {
                return (matches[1]...matches[2]).map { Position.init(x: matches[0], y: $0) }
            } else if let matches = yRegex.matches(in: claySpace)?.matches.compactMap(Int.init) {
                return (matches[1]...matches[2]).map { Position(x: $0, y: matches[0]) }
            } else {
                fatalError("Invalid input!")
            }
        }
        
        super.init()
        
        let grid = boundingRect().allPositionsMatrix()
        desert = grid.map { row in
            row.map { position in
                if claySpaces.contains(position) {
                    return Tile(tileType: .clay, position: position)
                } else {
                    return Tile(tileType: .sand, position: position)
                }
            }
        }
    }
    
    public override func part1() -> String {
        return super.part1()
    }
    
    public override func part2() -> String {
        return super.part2()
    }
    
    public func printableDesert() -> String {
        return desert.reduce(into: "", {
            $0 += $1.reduce(into: "", { $0 += $1.tileType.rawValue }) + "\n"
        })
    }
    
    public func boundingRect() -> CGRect {
        //let minX = claySpaces.map { $0.x }.min()!
        //let minY = claySpaces.map { $0.y }.min()!
        let width = claySpaces.map { $0.x }.max()!
        let height = claySpaces.map { $0.y }.max()!
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
}
