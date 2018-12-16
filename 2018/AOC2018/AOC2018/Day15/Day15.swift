import Foundation

public enum GroundType: String {
    case wall = "#"
    case open = "."
}

public class Unit {
    public enum Race: String {
        case elf = "E"
        case goblin = "G"
    }
    public let race: Race
    public var position: Position
    
    public var hp = 200
    public var power = 3
    
    public init(type: Race, position: Position) {
        self.race = type
        self.position = position
    }
    
    public static func from(_ type: String, position: Position) -> Unit? {
        if type == Unit.Race.goblin.rawValue {
            return Unit(type: .goblin, position: position)
        } else if type == Unit.Race.elf.rawValue {
            return Unit(type: .elf, position: position)
        } else {
            return nil
        }
    }
}

public final class Day15: Day {
    public var map: [[GroundType]]
    public var units: [Unit] = []

    public init(input: String) {
        let lines = input.components(separatedBy: .newlines)
        
        map = lines.map { row in row.exploded().map { $0 == "#" ? .wall : .open } }
        
        units = zip(lines.indices, lines).flatMap { y, row in
            zip(row.exploded().indices, row.exploded()).compactMap { x, elem in
                Unit.from(elem, position: Position(x: x, y: y))
            }
        }.sorted(by: { $0.position < $1.position })
    
        super.init()
    }
    
    public func printableMap() -> String {
        return map.reduce(into: "", {
            $0 += $1.reduce(into: "", { $0 += $1.rawValue }) + "\n"
        })
    }
    
    public func shortestPathToEnemy(from source: Unit) -> [Position] {
        return []
    }
    
    public func path(from source: Unit, to target: Unit) -> [Position] {
        var queue = [[source.position]]

        while queue.count > 0 {
            let path = queue.removeFirst()
            
            if path.last == target.position {
                return Array(path.dropFirst())
            } else if let current = path.last {
                for position in neighbors(for: current) {
                    queue.append(path + [position])
                }
            }
        }
        
        return []
    }
    
    private func allUnitPositions() -> [Position] {
         return units.map({ $0.position })
    }
    
    public func neighbors(for position: Position) -> [Position] {
        return [position.north(), position.west(), position.east(), position.south()]
            .filter { map[$0.y][$0.x].rawValue != GroundType.wall.rawValue }
    }
}

// Maybe faster, experiment later
//    public func path(from source: Unit, to target: Unit) -> [Position] {
//        var queue = [source.position]
//        var visitedTiles = Set<Position>()
//        var parentData: [Position: Position] = [:]
//
//        while queue.count > 0 {
//            let current = queue.removeFirst()
//
//            for position in neighbors(for: current) {
//                if target.position == position {
//                    parentData[position] = current
//                    return backtrace(parentData, source: source, target: target)
//                } else if !visitedTiles.contains(position) && !allUnitPositions().contains(position) {
//                    queue.append(position)
//                    visitedTiles.insert(position)
//                    parentData[position] = current
//                }
//            }
//        }
//
//        return []
//    }
//
//    private func backtrace(_ parent: [Position: Position], source: Unit, target: Unit) -> [Position] {
//        var path = [target.position]
//        while let lastPosition = path.last, lastPosition != source.position {
//            guard let position = parent[lastPosition] else { fatalError() }
//            path.append(position)
//        }
//        return path.reversed()
//    }
