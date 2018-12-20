import Foundation

public enum TileType: String {
    case spring = "+"
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
    private let claySpaces: Set<Position>
    private var desert: [[Tile]] = []
    private let springPosition: Position
    
    public init(input: String = Input().trimmedRawInput(), springXPosition: Int = 500) {
        springPosition = Position(x: springXPosition, y: 0)
        
        let xRegex = Regex.init(pattern: "^x=(\\d+), y=(\\d+)..(\\d+)$")
        let yRegex = Regex.init(pattern: "^y=(\\d+), x=(\\d+)..(\\d+)$")
        claySpaces = Set(input.components(separatedBy: .newlines).flatMap { claySpace -> [Position] in
            if let matches = xRegex.matches(in: claySpace)?.matches.compactMap(Int.init) {
                return (matches[1]...matches[2]).map { Position(x: matches[0], y: $0) }
            } else if let matches = yRegex.matches(in: claySpace)?.matches.compactMap(Int.init) {
                return (matches[1]...matches[2]).map { Position(x: $0, y: matches[0]) }
            } else {
                fatalError("Invalid input!")
            }
        })
        
        super.init()
        
        let grid = boundingRect().allPositionsMatrix()
        desert = grid.map { row in
            row.map { position in
                if springPosition == position {
                    return Tile(tileType: .spring, position: position)
                } else if claySpaces.contains(position) {
                    return Tile(tileType: .clay, position: position)
                } else {
                    return Tile(tileType: .sand, position: position)
                }
            }
        }
    }
    
    public override func part1() -> String {
        floodFill()
        return "\(allWaterTiles().count)"
    }
    
    public override func part2() -> String {
        floodFill()
        return "\(stillWaterTiles().count)"
    }
    
    public func floodFill() {
        _floodfill(position: springPosition.south())
    }
    
    private func _floodfill(position: Position) {
        guard tileType(at: position) == .sand else { return }

        var position = position
        while isWithinBounds(position.south()) && !isClay(position.south()) {
            desert[position.y][position.x].tileType = .flowing
            position = position.south()
        }
        
        desert[position.y][position.x].tileType = .flowing
        scanHorizontally(from: position)
    }
    
    private func scanHorizontally(from position: Position) {
        var rightMostPosition = position
        while isWithinBounds(rightMostPosition.east()) && isFilledBelow(rightMostPosition) && !isClay(rightMostPosition.east()) {
            rightMostPosition = rightMostPosition.east()
        }
        
        var leftMostPosition = position
        while isWithinBounds(leftMostPosition.west()) && isFilledBelow(leftMostPosition) && !isClay(leftMostPosition.west()) {
            leftMostPosition = leftMostPosition.west()
        }
        
        if isCapstoned(leftMostPosition, rightMostPosition) {
            ((leftMostPosition.x)...(rightMostPosition.x)).forEach { waterX in
                desert[position.y][waterX].tileType = .water
            }
            if isWithinBounds(position.north()) {
                scanHorizontally(from: position.north())
            }
        } else {
            ((leftMostPosition.x)...(rightMostPosition.x)).forEach { waterX in
                desert[position.y][waterX].tileType = .flowing
            }
            if isWithinBounds(leftMostPosition.south()) && !isClay(leftMostPosition.south()) {
                _floodfill(position: leftMostPosition.south())
            }
            if isWithinBounds(rightMostPosition.south()) && !isClay(rightMostPosition.south()) {
                _floodfill(position: rightMostPosition.south())
            }
        }
    }
    
    private func isCapstoned(_ left: Position, _ right: Position) -> Bool {
        return isWithinBounds(left.west()) && isWithinBounds(right.east()) &&
            isClay(left.west()) && isClay(right.east())
    }
    
    private func isFilledBelow(_ position: Position) -> Bool {
         return isWithinBounds(position.south()) &&
            (tileType(at: position.south()) == .clay || tileType(at: position.south()) == .water)
    }
    
    public func printableDesert() -> String {
        return desert.reduce(into: "", {
            $0 += $1.reduce(into: "", { $0 += $1.tileType.rawValue }) + "\n"
        })
    }
    
    public func boundingRect() -> CGRect {
        let width = claySpaces.map { $0.x }.max()! + 2
        let height = claySpaces.map { $0.y }.max()!
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    private func isWithinBounds(_ position: Position) -> Bool {
        return position.y > 0 && position.y < desert.count &&
            position.x >= 0 && position.x < desert[position.y].count
    }

    private func isClay(_ position: Position) -> Bool {
        return tileType(at: position) == .clay
    }
    
    private func tileType(at position: Position) -> TileType {
        return desert[position.y][position.x].tileType
    }
    
    private func allWaterTiles() -> [Tile] {
        let minY = claySpaces.map { $0.y }.min()!
        return desert.lazy.flatMap { $0 }
            .filter { ($0.tileType == .water || $0.tileType == .flowing) && $0.position.y >= minY }
    }
    
    private func stillWaterTiles() -> [Tile] {
        return allWaterTiles().filter { $0.tileType == .water }
    }
}
