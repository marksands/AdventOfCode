import Foundation
import AdventOfCode

public final class Day3: Day {
    private let path1: String
    private let path2: String
    
    public init(path1: String, path2: String) {
        self.path1 = path1
        self.path2 = path2
    }
    
    public override func part1() -> String {
        let origin = Position(x: 0, y: 0)
        var currentPosition = Position(x: 0, y: 0)
        var positions: [Position: [String]] = [:]
        
        path1.components(separatedBy: ",").forEach { step in
            if step.hasPrefix("R") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.east()
                    positions[currentPosition, default: []] += ["1"]
                }

            } else if step.hasPrefix("U") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.north()
                    positions[currentPosition, default: []] += ["1"]
                }

            } else if step.hasPrefix("L") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.west()
                    positions[currentPosition, default: []] += ["1"]
                }

            } else if step.hasPrefix("D") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.south()
                    positions[currentPosition, default: []] += ["1"]
                }
            }
        }
        
        currentPosition = origin

        path2.components(separatedBy: ",").forEach { step in
            if step.hasPrefix("R") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.east()
                    positions[currentPosition, default: []] += ["2"]
                }
                
            } else if step.hasPrefix("U") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.north()
                    positions[currentPosition, default: []] += ["2"]
                }
                
            } else if step.hasPrefix("L") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.west()
                    positions[currentPosition, default: []] += ["2"]
                }
                
            } else if step.hasPrefix("D") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.south()
                    positions[currentPosition, default: []] += ["2"]
                }
            }
        }

        let intersections = positions.filter({ $0.value == ["1", "2"] })
        let position = intersections.keys.sorted(by: { $0.manhattanDistance(to: origin) < $1.manhattanDistance(to: origin) }).first!
        
        return String(position.manhattanDistance(to: origin))
    }
    
    public override func part2() -> String {
        let origin = Position(x: 0, y: 0)
        var currentPosition = Position(x: 0, y: 0)
        var positions: [Position: [String]] = [:]
        
        path1.components(separatedBy: ",").forEach { step in
            if step.hasPrefix("R") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.east()
                    positions[currentPosition, default: []] += ["1"]
                }

            } else if step.hasPrefix("U") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.north()
                    positions[currentPosition, default: []] += ["1"]
                }

            } else if step.hasPrefix("L") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.west()
                    positions[currentPosition, default: []] += ["1"]
                }

            } else if step.hasPrefix("D") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.south()
                    positions[currentPosition, default: []] += ["1"]
                }
            }
        }
        
        currentPosition = origin

        path2.components(separatedBy: ",").forEach { step in
            if step.hasPrefix("R") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.east()
                    positions[currentPosition, default: []] += ["2"]
                }
                
            } else if step.hasPrefix("U") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.north()
                    positions[currentPosition, default: []] += ["2"]
                }
                
            } else if step.hasPrefix("L") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.west()
                    positions[currentPosition, default: []] += ["2"]
                }
                
            } else if step.hasPrefix("D") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.south()
                    positions[currentPosition, default: []] += ["2"]
                }
            }
        }

        let intersections = Array(positions.filter({ $0.value == ["1", "2"] }).keys)
        var stepPositions: [Position: [Int]] = [:]
        
        currentPosition = origin

        var stepCount = 0
        path1.components(separatedBy: ",").forEach { step in
            if step.hasPrefix("R") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.east(); stepCount += 1
                    if intersections.contains(currentPosition) {
                        stepPositions[currentPosition, default: []] += [stepCount]
                    }
                }

            } else if step.hasPrefix("U") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.north(); stepCount += 1
                    if intersections.contains(currentPosition) {
                        stepPositions[currentPosition, default: []] += [stepCount]
                    }
                }

            } else if step.hasPrefix("L") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.west(); stepCount += 1
                    if intersections.contains(currentPosition) {
                        stepPositions[currentPosition, default: []] += [stepCount]
                    }
                }

            } else if step.hasPrefix("D") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.south(); stepCount += 1
                    if intersections.contains(currentPosition) {
                        stepPositions[currentPosition, default: []] += [stepCount]
                    }
                }
            }
        }
        
        currentPosition = origin

        stepCount = 0
        path2.components(separatedBy: ",").forEach { step in
            if step.hasPrefix("R") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.east(); stepCount += 1
                    if intersections.contains(currentPosition) {
                        stepPositions[currentPosition, default: []] += [stepCount]
                    }
                }

            } else if step.hasPrefix("U") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.north(); stepCount += 1
                    if intersections.contains(currentPosition) {
                        stepPositions[currentPosition, default: []] += [stepCount]
                    }
                }

            } else if step.hasPrefix("L") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.west(); stepCount += 1
                    if intersections.contains(currentPosition) {
                        stepPositions[currentPosition, default: []] += [stepCount]
                    }
                }

            } else if step.hasPrefix("D") {
                let steps = Int(String(step.dropFirst()))!
                (0..<steps).forEach { step in
                    currentPosition = currentPosition.south(); stepCount += 1
                    if intersections.contains(currentPosition) {
                        stepPositions[currentPosition, default: []] += [stepCount]
                    }
                }
            }
        }
        
        return String(stepPositions.values.map { $0.sum() }.min()!)
    }
}
