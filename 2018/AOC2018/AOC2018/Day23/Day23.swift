import Foundation

struct Nanobot {
    let position: Position
    let radius: Int
}

public final class Day23: Day {
    private let nanobots: [Nanobot]
    
    public override init() {
        let regex = Regex(pattern: "^pos=<(-?\\d+),(-?\\d+),(-?\\d+)>, r=(\\d+)$")
        nanobots = Input().trimmedInputCharactersByNewlines().map { line -> Nanobot in
            let matches = regex.matches(in: line)!.matches.compactMap(Int.init)
            let position = Position(x: matches[0], y: matches[1], z: matches[2])
            return Nanobot(position: position, radius: matches[3])
        }
        super.init()
    }
    
    public override func part1() -> String {
        let largestRadiusBot = nanobots.max(by: { $0.radius < $1.radius })!
        
        let count = nanobots.reduce(0) {
            $0 + ($1.position.manhattenDistance(to: largestRadiusBot.position) <= largestRadiusBot.radius ? 1 : 0)
        }
        
        return "\(count)"
    }

    public override func part2() -> String {
        var xRange = nanobots.map { $0.position.x }.min()!...nanobots.map { $0.position.x }.max()!
        var yRange = nanobots.map { $0.position.y }.min()!...nanobots.map { $0.position.y }.max()!
        var zRange = nanobots.map { $0.position.z }.min()!...nanobots.map { $0.position.z }.max()!
        var midX = (xRange.lowerBound + xRange.upperBound)/2
        var midY = (yRange.lowerBound + yRange.upperBound)/2
        var midZ = (zRange.lowerBound + zRange.upperBound)/2
        
        var coordinate = Position.zero
        var maxCount = 0

        let validatePosition = { [unowned self] (position: Position) in
            let count = self.nanobots.count(where: { $0.position.manhattenDistance(to: position) <= $0.radius })
            if count > maxCount || (count == maxCount && position.manhattenDistance(to: .zero) < coordinate.manhattenDistance(to: .zero)) {
                print("Got \(count) for \(position)")
                maxCount = count
                coordinate = position
            }
        }
        
        (1...32).reversed().map { 1 << $0 }.forEach { step in
            stride(from: xRange.lowerBound, to: midX, by: step).forEach { x in
                stride(from: yRange.lowerBound, to: midY, by: step).forEach { y in
                    stride(from: zRange.lowerBound, to: midZ, by: step).forEach { z in
                        validatePosition(Position(x: x, y: y, z: z))
                    }
                    stride(from: midZ, to: zRange.upperBound, by: step).forEach { z in
                        validatePosition(Position(x: x, y: y, z: z))
                    }
                }
                stride(from: midY, to: yRange.upperBound, by: step).forEach { y in
                    stride(from: zRange.lowerBound, to: midZ, by: step).forEach { z in
                        validatePosition(Position(x: x, y: y, z: z))
                    }
                    stride(from: midZ, to: zRange.upperBound, by: step).forEach { z in
                        validatePosition(Position(x: x, y: y, z: z))
                    }
                }
            }

            stride(from: midX, to: xRange.upperBound, by: step).forEach { x in
                stride(from: yRange.lowerBound, to: midY, by: step).forEach { y in
                    stride(from: zRange.lowerBound, to: midZ, by: step).forEach { z in
                        validatePosition(Position(x: x, y: y, z: z))
                    }
                    stride(from: midZ, to: zRange.upperBound, by: step).forEach { z in
                        validatePosition(Position(x: x, y: y, z: z))
                    }
                }
                stride(from: midY, to: yRange.upperBound, by: step).forEach { y in
                    stride(from: zRange.lowerBound, to: midZ, by: step).forEach { z in
                        validatePosition(Position(x: x, y: y, z: z))
                    }
                    stride(from: midZ, to: zRange.upperBound, by: step).forEach { z in
                        validatePosition(Position(x: x, y: y, z: z))
                    }
                }
            }
            
            let range = (step * 58)/2
            
            xRange = (coordinate.x - range)...(coordinate.x + range)
            yRange = (coordinate.y - range)...(coordinate.y + range)
            zRange = (coordinate.z - range)...(coordinate.z + range)

            midX = (xRange.lowerBound + xRange.upperBound)/2
            midY = (yRange.lowerBound + yRange.upperBound)/2
            midZ = (zRange.lowerBound + zRange.upperBound)/2
        }
        
        return "\(coordinate.manhattenDistance(to: .zero))"
    }
}
