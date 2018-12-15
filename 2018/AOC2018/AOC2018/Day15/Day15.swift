import Foundation

enum GroundType: String {
    case wall = "#"
    case open = "."
}

class Unit {
    enum UnitType: String {
        case elf = "E"
        case goblin = "G"
    }
    let type: UnitType
    var location: Position
    
    var hp = 200
    var power = 3
    
    init(type: UnitType, location: Position) {
        self.type = type
        self.location = location
    }
    
    static func from(_ type: String, location: Position) -> Unit? {
        if type == Unit.UnitType.goblin.rawValue {
            return Unit(type: .goblin, location: location)
        } else if type == Unit.UnitType.elf.rawValue {
            return Unit(type: .elf, location: location)
        } else {
            return nil
        }
    }
}

public final class Day15: Day {
    var level: [[GroundType]]
    var units: [Unit] = []

    public override init() {
        let input = """
            #######
            #.G...#
            #...EG#
            #.#.#G#
            #..G#E#
            #.....#
            #######
            """
        
        let lines = input.components(separatedBy: .newlines)
        
        level = lines.map { row in row.exploded().map { $0 == "#" ? .wall : .open } }
        
        units = zip(lines.indices, lines).flatMap { y, row in
            zip(row.exploded().indices, row.exploded()).compactMap { x, elem in
                Unit.from(elem, location: Position(x: x, y: y))
            }
        }.sorted(by: { $0.location < $1.location })
    
        super.init()
    }
    
    public override func part1() -> String {
        return "TBD"
    }
    
    public override func part2() -> String {
        return super.part2()
    }
    
    public func printableMap() -> String {
        return level.reduce(into: "", {
            $0 += $1.reduce(into: "", { $0 += $1.rawValue }) + "\n"
        })
    }
}
