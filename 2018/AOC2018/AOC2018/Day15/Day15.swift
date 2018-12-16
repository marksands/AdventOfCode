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

public enum RoundResult {
    case completed
    case halted
    case finished
}

public final class Day15: Day {
    public var map: [[GroundType]]
    public var units: [Unit] = []

    public init(input: String = Input().rawInput()) {
        let lines = input.trimmingCharacters(in: .newlines).components(separatedBy: .newlines)
        
        map = lines.map { row in row.exploded().map { $0 == "#" ? .wall : .open } }
        
        units = zip(lines.indices, lines).flatMap { y, row in
            zip(row.exploded().indices, row.exploded()).compactMap { x, elem in
                Unit.from(elem, position: Position(x: x, y: y))
            }
        }.sorted(by: { $0.position < $1.position })
    
        super.init()
    }
    
    public override func part1() -> String {
        var roundCount = 0
        while true {
            if battle() == .completed {
                roundCount += 1
            } else {
                break
            }
            print(printableRound())
        }
        return String(livingUnits().reduce(0, { $0 + $1.hp }) * roundCount)
    }
    
    @discardableResult
    public func battle() -> RoundResult {
        for source in livingUnits() {
            if let target = enemyWithinRange(of: source) {
                target.hp -= source.power
            } else if let nextPosition = shortestPathToEnemy(from: source).first {
                source.position = nextPosition
                if let target = enemyWithinRange(of: source) {
                    target.hp -= source.power
                }
            }
            if livingUnits().map({ $0.race }).unique().count == 1 {
                return .halted
            }
        }
        return livingUnits().map({ $0.race }).unique().count > 1 ? .completed : .finished
    }
    
    public func enemyWithinRange(of source: Unit) -> Unit? {
        let adjacentEnemies = enemies(of: source).filter { neighbors(for: source.position).contains($0.position) }
        return adjacentEnemies.sorted { $0.hp < $1.hp }.first
    }
        
    public func shortestPathToEnemy(from source: Unit) -> [Position] {
        let possiblePaths = enemies(of: source).map { path(from: source, to: $0) }.filter { $0.count > 0 }
        return possiblePaths.min(by: { $0.count < $1.count }) ?? []
    }
    
    public func path(from source: Unit, to target: Unit) -> [Position] {
        precondition(source.race != target.race)
        
        var queue = [[source.position]]
        var visitedTiles = Set<Position>()
        let skippingUnits = allUnitPositions().filter { $0 != target.position }

        while queue.count > 0 {
            let path = queue.removeFirst()
            
            if path.last == target.position {
                return Array(path.dropFirst())
            } else if let current = path.last {
                for position in neighbors(for: current) {
                    if !visitedTiles.contains(position) && !skippingUnits.contains(position) {
                        visitedTiles.insert(position)
                        queue.append(path + [position])
                    }
                }
            }
        }
        
        return []
    }

    public func neighbors(for position: Position) -> [Position] {
        return [position.north(), position.west(), position.east(), position.south()]
            .filter { map[$0.y][$0.x].rawValue != GroundType.wall.rawValue }
    }
    
    private func enemies(of source: Unit) -> [Unit] {
        return livingUnits().filter { $0.race != source.race }
    }
    
    private func allUnitPositions() -> [Position] {
        return livingUnits().map({ $0.position })
    }
    
    private func livingUnits() -> [Unit] {
        return units.filter { $0.hp > 0 }.sorted(by: { $0.position < $1.position })
    }
}

extension Day15 {
    public func printableMap() -> String {
        return map.reduce(into: "", {
            $0 += $1.reduce(into: "", { $0 += $1.rawValue }) + "\n"
        })
    }
    
    public func printableRound() -> String {
        var result = ""
        zip(map.indices, map).forEach { y, row in
            var unitsInSeries: [Unit] = []
            zip(row.indices, row).forEach { x, tile in
                let position = Position(x: x, y: y)
                if let unit = livingUnits().first(where: { $0.position == position }) {
                    unitsInSeries.append(unit)
                    result += unit.race.rawValue
                } else {
                    result += tile.rawValue
                }
            }
            
            if unitsInSeries.count > 0 {
                result += "   "
                result += unitsInSeries.reduce(into: "") { $0 += "\($1.race.rawValue)(\($1.hp)), " }.dropLast(2)
            }

            result += "\n"
        }
        return result
    }
}
