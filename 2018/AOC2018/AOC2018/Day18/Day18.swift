import Foundation

public enum WoodlandType: String {
    case lumberyard = "#"
    case trees = "|"
    case open = "."
}

public final class Day18: Day {
    private var woodland: [Position: WoodlandType] = [:]
    private var treeCount = 0
    private var lumberyardCount = 0
    
    public override init() {
        super.init()
        
        Input().trimmedInputCharactersByNewlines().enumerated().forEach { y, line in
            line.exploded().enumerated().forEach { x, tile in
                let position = Position(x: x, y: y)
                let type = WoodlandType(rawValue: tile)!
                if type == .lumberyard {
                    lumberyardCount += 1
                } else if type == .trees {
                    treeCount += 1
                }
                woodland[position] = type
            }
        }
    }
    
    public override func part1() -> String {
        (1...10).forEach { _ in mutate() }
        return String(lumberyardCount * treeCount)
    }
    
    public override func part2() -> String {
        var previousResults: [Int: Int] = [:]
        var result = 0
        var previous = 0
        
        for round in (1...) {
            mutate()
            result = lumberyardCount*treeCount
            let current = round - previousResults[result, default: 0]
            previousResults[result] = round

            if current == previous && 1_000_000_000 % current == round % current {
                return String(result)
            }
            previous = current
        }
        return String(result)
    }

    public func mutate() {
        var positionChanges: [Position: WoodlandType] = [:]
        
        (0..<2500).forEach { index in
            let position = Position(x: index / 50, y: index % 50)
            let woodlandType = woodland[position]
            let surroundedTiles = Set(position.surrounding()).compactMap { woodland[$0] }
            
            if woodlandType == .open {
                let nearbyTrees = surroundedTiles.count(where: { $0 == .trees })
                if nearbyTrees >= 3 {
                    treeCount += 1
                    positionChanges.updateValue(.trees, forKey: position)
                }
            } else if woodlandType == .trees {
                let nearbyLumberYards = surroundedTiles.count(where: { $0 == .lumberyard })
                if nearbyLumberYards >= 3 {
                    treeCount -= 1
                    lumberyardCount += 1
                    positionChanges.updateValue(.lumberyard, forKey: position)
                }
            } else if woodlandType == .lumberyard {
                if !(surroundedTiles.count(where: { $0 == .trees }) > 0 && surroundedTiles.count(where: { $0 == .lumberyard }) > 0) {
                    lumberyardCount -= 1
                    positionChanges.updateValue(.open, forKey: position)
                }
            }
        }
        
        for (position, type) in positionChanges {
            woodland[position] = type
        }
    }
}
