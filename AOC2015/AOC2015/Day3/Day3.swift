import Foundation
import AdventOfCode

public final class Day3: Day {
    private let directions = Input().trimmedRawInput().exploded()
    
    public override func part1() -> String {
        var current = Position.zero
        var houses = [current: 1]
        
        directions.forEach { arrow in
            current = navigate(position: current, arrow: arrow)
            houses[current, default: 0] += 1
        }
        
        return String(houses.keys.count)
    }
    
    public override func part2() -> String {
        var santa = Position.zero
        var robot = Position.zero
        var houses = [santa: 2]
        
        zip(directions.indices, directions).forEach { index, arrow in
            if index % 2 == 0 {
                robot = navigate(position: robot, arrow: arrow)
                houses[robot, default: 0] += 1
            } else {
                santa = navigate(position: santa, arrow: arrow)
                houses[santa, default: 0] += 1
            }
        }
        
        return String(houses.keys.count)
    }
    
    private func navigate(position: Position, arrow: String) -> Position {
        switch arrow {
        case "^": return position.north()
        case ">": return position.east()
        case "<": return position.west()
        case "v": return position.south()
        default:
            fatalError()
        }
    }
}
