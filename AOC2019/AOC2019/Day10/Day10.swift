import Foundation
import AdventOfCode

public final class Day10: Day {
    var grid: [String] = []
    
    public override init() {
        grid = Input().trimmedInputCharactersByNewlines()
    }
    
    public override func part1() -> String {
        var maxCount = 0
        var position = Position.zero
        
        grid.enumerated().forEach { y, row in
            row.enumerated().forEach { x, e in
                if e == "#" {
                    let count = countOfAsteroidsInLineOfSight(x: x, y: y)
                    maxCount = max(maxCount, count)
                    if maxCount == count {
                        position = Position(x: x, y: y)
                    }
                }
            }
        }
        
        print(position)
        return String(maxCount)
    }
    
    private func countOfAsteroidsInLineOfSight(x: Int, y: Int) -> Int {
        var seenAngles = Set<Double>()
        
        grid.enumerated().forEach { j, row in
            row.enumerated().forEach { i, e in
                if e == "#" {
                    let angle = atan2(Double(j - y), Double(i - x))
                    seenAngles.insert(angle)
                }
            }
        }
        
        return seenAngles.count
    }
    
    public override func part2() -> String {
        let station = Position(x: 17, y: 22)
        var asteroidsToPolarCoords: [Position: (angle: Double, r: Double)] = [:]

        grid.enumerated().forEach { j, row in
            row.enumerated().forEach { i, e in
                let asteroid = Position(x: i, y: j)
                if e == "#" && asteroid != station {
                    var angle = (atan2(Double(j - station.y), Double(i - station.x)))
                    if angle < -Double.pi/2.0 {
                        angle += 2 * Double.pi
                    }
                    let r = hypot(Double(j - station.y), Double(i - station.x))
                    if asteroid.x == 17 && asteroid.y == 19 {
                        
                    }
                    asteroidsToPolarCoords[asteroid] = (angle, r)
                }
            }
        }
                
        let lowestAngles = asteroidsToPolarCoords
            .sorted { ($0.value.angle, $0.value.r) < ($1.value.angle, $1.value.r) }

        var seen: [Double: Bool] = [:]
        let lowestAnglesFirstPass = lowestAngles.filter { seen.updateValue(true, forKey: $0.value.angle) == nil }
                
        let found = lowestAnglesFirstPass[199].key
        
        return String(found.x * 100 + found.y)
    }
}
