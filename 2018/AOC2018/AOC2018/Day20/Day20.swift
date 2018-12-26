import Foundation

enum MazeTile: String {
    case start = "^"
    case end = "$"
    case N = "N"
    case S = "S"
    case E = "E"
    case W = "W"
    case branchOpen = "("
    case branchClose = ")"
    case pipe = "|"
}

public final class Day20: Day {
    private var distances: [Position: Int] = [:]

    public override init() {
        super.init()
        
        var positions: [Position] = []
        var currentPosition = Position(x: 0, y: 0)
        
        Input().trimmedRawInput().exploded().compactMap(MazeTile.init).forEach { tile in
            switch tile {
            case .start, .end:
                break
            case .branchOpen:
                positions.append(currentPosition)
            case .branchClose:
                currentPosition = positions.popLast()!
            case .pipe:
                currentPosition = positions.last!
            case .N, .S, .E, .W:
                let newPosition = [MazeTile.N: currentPosition.north(), MazeTile.S: currentPosition.south(), MazeTile.E: currentPosition.east(), MazeTile.W: currentPosition.west()][tile]!
                distances[newPosition] = min(distances[newPosition, default: Int.max], distances[currentPosition, default: 0] + 1)
                currentPosition = newPosition
            }
        }
    }

    public override func part1() -> String {
        return String(distances.values.max()!)
    }
    
    public override func part2() -> String {
        return String(distances.values.count(where: { $0 >= 1000 }))
    }
}
