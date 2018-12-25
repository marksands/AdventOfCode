import Foundation

class Constellation {
    var positions: [Position] = []
    
    func isWithinRange(_ position: Position) -> Bool {
        return positions.reduce(false) { $0 || $1.manhattenDistance(to: position) <= 3 }
    }
    
    func isWithinRange(of constellation: Constellation) -> Bool {
        return positions.reduce(false) { (seed, position) in
            seed || constellation.positions.reduce(false) { $0 || $1.manhattenDistance(to: position) <= 3 }
        }
    }
    
    func merge(_ constellation: Constellation) {
        positions.append(contentsOf: constellation.positions)
        constellation.positions.removeAll()
    }
}

public final class Day25: Day {
    public override func part1() -> String {
        let regex = Regex.init(pattern: "^(-?\\d+),(-?\\d+),(-?\\d+),(-?\\d+)$")
        
        let values = Input().trimmedRawInput().components(separatedBy: .newlines)
            .map { regex.matches(in: $0)!.matches.compactMap(Int.init) }
            .map { Position(x: $0[0], y: $0[1], z: $0[2], w: $0[3]) }
        
        var constellations: [Constellation] = []
        
        values.forEach { position in
            if let constellation = constellations.first(where: { $0.isWithinRange(position) }) {
                constellation.positions.append(position)
            } else {
                let newConstellation = Constellation()
                newConstellation.positions.append(position)
                constellations.append(newConstellation)
            }
        }
        
        constellations.forEach { constellation in
            if let c = constellations.first(where: { $0 !== constellation && $0.isWithinRange(of: constellation) }) {
                c.merge(constellation)
            }
        }
        
        return "\(constellations.count(where: { !$0.positions.isEmpty }))"
    }
}
