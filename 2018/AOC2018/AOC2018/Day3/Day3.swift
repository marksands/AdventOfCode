import UIKit

public final class Day3: Day {
    private let claims: [CGRect]
    
    public override init() {
        let rows = Input().trimmedInputCharactersByNewlines()
        claims = rows.map {
            let claim = $0.components(separatedBy: .whitespaces)
            let offset = claim[2].replacingOccurrences(of: ":", with: "").components(separatedBy: ",").compactMap(Int.init)
            let origin = CGPoint(x: offset[0], y: offset[1])
            let area = claim[3].components(separatedBy: "x").compactMap(Int.init)
            let size = CGSize(width: area[0], height: area[1])
            return CGRect(origin: origin, size: size)
        }
    }
    
    public override func part1() -> String {
        return "\(part1Result())"
    }
    
    public override func part2() -> String {
        return "\(part2Result())"
    }
    
    private func part1Result() -> Int {
        var coordinateSet = Set<String>()
        zip(claims.indices, claims).forEach { index1, rect1 in
            zip(claims.indices, claims).forEach { index2, rect2 in
                if index1 != index2 {
                    if rect1.intersects(rect2) {
                        let intersection = rect1.intersection(rect2)
                        (Int(intersection.origin.x)..<Int(intersection.origin.x + intersection.size.width)).forEach { x in
                            (Int(intersection.origin.y)..<Int(intersection.origin.y + intersection.size.height)).forEach { y in
                                coordinateSet.insert("\(x),\(y)")
                            }
                        }
                    }
                }
            }
        }
        return coordinateSet.count
    }
    
    private func part2Result() -> Int {
        for (index1, rect1) in zip(claims.indices, claims) {
            var intersected = false
            for (index2, rect2) in zip(claims.indices, claims) {
                if index1 != index2 {
                    if rect1.intersects(rect2) {
                        intersected = true
                    }
                }
            }
            if !intersected {
                return index1 + 1
            }
        }
        return 0
    }
}
