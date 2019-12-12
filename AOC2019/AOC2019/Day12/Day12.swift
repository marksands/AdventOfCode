import Foundation
import AdventOfCode

public final class Day12: Day {
    class Moon {
        var name: String
        var position: Position
        var velocity: Position = Position(x: 0, y: 0, z: 0)
        
        init(name: String, position: Position) {
            self.name = name
            self.position = position
        }
        
        func stepped(moons: [Moon]) -> Position {
            let others = moons.filter { $0.name != name }
            let gravity = others.reduce(Position.zero) { $0 +
                Position(
                    x: $1.position.x > position.x ? 1 : ($1.position.x < position.x ? -1 : 0),
                    y: $1.position.y > position.y ? 1 : ($1.position.y < position.y ? -1 : 0),
                    z: $1.position.z > position.z ? 1 : ($1.position.z < position.z ? -1 : 0)
                )
            }
            return velocity + gravity
        }
        
        func steppedX(moons: [Moon]) -> Int {
            let others = moons.filter { $0.name != name }
            let gravity = others.reduce(0) { $0 +
                $1.position.x > position.x ? 1 : ($1.position.x < position.x ? -1 : 0)
            }
            return velocity.x + gravity
        }
        
        func energy() -> Int {
            let potentialEnergy = Int(abs(position.x) + abs(position.y) + abs(position.z))
            let kineticEnergy = Int(abs(velocity.x) + abs(velocity.y) + abs(velocity.z))
            return potentialEnergy * kineticEnergy
        }
    }

    let moons: [Moon]
    
    public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
        let regex = Regex.init(pattern: "^<x=(-?\\d+), y=(-?\\d+), z=(-?\\d+)>$")
        
        let positions = input
            .map { regex.matches(in: $0)!.matches.compactMap(Int.init) }
            .map { Position(x: $0[0], y: $0[1], z: $0[2]) }
        
        moons = zip(["Io", "Europa", "Ganymede", "Callisto"], positions).map {
            Moon(name: $0, position: $1)
        }
    }
    
    public override func part1() -> String {
        (0..<1_000).forEach { _ in
            var moonToVelocity: [String: Position] = [:]
            
            moons.forEach { moon in
                let velocity = moon.stepped(moons: moons)
                moonToVelocity[moon.name] = velocity
            }
            
            moonToVelocity.forEach({ dict in
                let moon = moons.first(where: { $0.name == dict.key })!
                moon.position = moon.position + dict.value
                moon.velocity = dict.value
            })
        }
        
        let energy = moons.reduce(0) { $0 + $1.energy() }
        
        return String(energy)
    }
    
    struct AxisCoords: Hashable {
        let x1: Int
        let x2: Int
        let x3: Int
        let x4: Int
    }
    
    public override func part2() -> String {
        var seenX = Set<AxisCoords>()
        
        for _ in (0..<4_686_774_924) {
            var moonToVelocity: [String: Int] = [:]
            
            moons.forEach { moon in
                let velocityX = moon.steppedX(moons: moons)
                moonToVelocity[moon.name] = velocityX
            }
            
            let axis = AxisCoords(x1: moons[0].position.x, x2: moons[1].position.x, x3: moons[2].position.x, x4: moons[3].position.x)
            if seenX.contains(axis) {
                print("axis! \(axis)")
                break
            }

            seenX.insert(axis)
            
            moonToVelocity.forEach({ dict in
                let moon = moons.first(where: { $0.name == dict.key })!
                moon.position.x = moon.position.x + dict.value
                moon.velocity.x = dict.value
            })
        }
                
        return ""
    }
}
