import Foundation
import AdventOfCode

public final class Day12: Day {
    class Moon {
        var name: String
        var position: Position
        var velocity: Position = Position(x: 0, y: 0, z: 0)
        
        var x: [Int] { return [position.x, velocity.x] }
        var y: [Int] { return [position.y, velocity.y] }
        var z: [Int] { return [position.z, velocity.z] }
        
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
    
    func step() {
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
    
    public override func part1() -> String {
        (0..<1_000).forEach { _ in
            step()
        }
        
        let energy = moons.reduce(0) { $0 + $1.energy() }
        
        return String(energy)
    }
    
    struct AxisCoords: Hashable {
        let pvs: [[Int]]
    }
    
    public override func part2() -> String {
        var seenX2 = Set<AxisCoords>()
        var seenY2 = Set<AxisCoords>()
        var seenZ2 = Set<AxisCoords>()

        var x_axis = AxisCoords(pvs: moons.map { $0.x })
        var y_axis = AxisCoords(pvs: moons.map { $0.y })
        var z_axis = AxisCoords(pvs: moons.map { $0.z })

        var cnts: [Int] = [0, 0, 0]
        
        for _ in (0...) {
            step()
            
            x_axis = AxisCoords(pvs: moons.map { $0.x })
            y_axis = AxisCoords(pvs: moons.map { $0.y })
            z_axis = AxisCoords(pvs: moons.map { $0.z })

            if seenX2.contains(x_axis) {
                cnts[0] = seenX2.count
            }
            seenX2.insert(x_axis)

            if seenY2.contains(y_axis) {
                cnts[1] = seenY2.count
            }
            seenY2.insert(y_axis)

            if seenZ2.contains(z_axis) {
                cnts[2] = seenZ2.count
            }
            seenZ2.insert(z_axis)
            
            if cnts.allSatisfy({ $0 > 0 }) {
                break
            }
        }
        
        // 186028, 286332, 96236
        let steps = lcm(cnts)
            
        return String(steps)
    }
}
