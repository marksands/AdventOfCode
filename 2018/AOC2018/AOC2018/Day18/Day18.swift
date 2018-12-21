import Foundation

public enum WoodlandType: String {
    case lumberyard = "#"
    case trees = "|"
    case open = "."
}

public final class Acre: Equatable, Hashable {
    public static func == (lhs: Acre, rhs: Acre) -> Bool {
        return lhs.position == rhs.position
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(position)
    }
    
    public var woodlandType: WoodlandType
    public let position: Position
    
    public init(position: Position, type: WoodlandType) {
        self.position = position
        self.woodlandType = type
    }
}

public final class Day18: Day {
    private let woodland: [Acre]
    
    public init(input: String = Input().trimmedRawInput()) {
        woodland = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).enumerated().flatMap { y, line in
            line.exploded().enumerated().map { x, tile -> Acre in
                let position = Position(x: x, y: y)
                return Acre(position: position, type: WoodlandType(rawValue: tile)!)
            }
        }

        super.init()
    }
    
    public override func part1() -> String {
        (1...10).forEach { round in
            mutate()
        }
        let lumberyards = woodland.count(where: { $0.woodlandType == .lumberyard })
        let trees = woodland.count(where: { $0.woodlandType == .trees })
        return String(lumberyards * trees)
    }
    
    public override func part2() -> String {
        (1...1_000_000_000).forEach { round in
            mutate()
            let lumberyards = woodland.count(where: { $0.woodlandType == .lumberyard })
            let trees = woodland.count(where: { $0.woodlandType == .trees })
            print("\(lumberyards), \(trees), \(lumberyards*trees)")
        }
        let lumberyards = woodland.count(where: { $0.woodlandType == .lumberyard })
        let trees = woodland.count(where: { $0.woodlandType == .trees })
        return String(lumberyards * trees)
    }

    public func mutate() {
        var positionChanges: [Position: WoodlandType] = [:]
        
        woodland.forEach { acre in
            let surroundedPositions = Set(acre.position.surrounding())

            if acre.woodlandType == .open {
                let nearbyTrees = woodland.count(where: { surroundedPositions.contains($0.position) && $0.woodlandType == .trees })
                if nearbyTrees >= 3 {
                    positionChanges.updateValue(.trees, forKey: acre.position)
                }
            } else if acre.woodlandType == .trees {
                let nearbyLumberYards = woodland.count(where: { surroundedPositions.contains($0.position) && $0.woodlandType == .lumberyard })
                if nearbyLumberYards >= 3 {
                    positionChanges.updateValue(.lumberyard, forKey: acre.position)
                }
            } else if acre.woodlandType == .lumberyard {
                let nearbyTrees = woodland.count(where: { surroundedPositions.contains($0.position) && $0.woodlandType == .trees })
                let nearbyLumberYards = woodland.count(where: { surroundedPositions.contains($0.position) && $0.woodlandType == .lumberyard })
                if !(nearbyTrees > 0 && nearbyLumberYards > 0) {
                    positionChanges.updateValue(.open, forKey: acre.position)
                }
            }
        }
        
        for (position, type) in positionChanges {
            woodland[position.x + 50 * position.y].woodlandType = type
        }
    }
    
    public func boundingRect() -> CGRect {
        let dimension = Int(sqrt(Double(woodland.count)))
        return CGRect(x: 0, y: 0, width: dimension, height: dimension)
    }
    
    public func printableBoard() -> String {
        return woodland.chunks(ofSize: Int(boundingRect().width)).reduce(into: "") { $0 +=
            $1.reduce(into: "") { $0 += $1.woodlandType.rawValue } + "\n"
        }
    }
}
