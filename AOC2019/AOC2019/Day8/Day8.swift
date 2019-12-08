import Foundation
import AdventOfCode

public final class Day8: Day {
    private let layers = Array(Input().trimmedRawInput()).chunks(ofSize: 25 * 6)
    
    public override func part1() -> String {
        let fewestZeros = layers.min(by: { $0.count { $0 == "0" } < $1.count { $0 == "0" } })!
        return String(fewestZeros.count { String($0) == "1" } * fewestZeros.count { String($0) == "2" })
    }
    
    public override func part2() -> String {
        var picture = Array(repeating: " ", count: 25 * 6)
        
        layers.reversed().forEach { layer in
            picture = zip(picture, layer).map { p, l in
                return l == "0" ? "⬛️" : l == "1" ? "⬜️" : p
            }
        }
        
        picture.chunks(ofSize: 25).forEach { row in
            print(row.joined())
        }

        return ""
    }
}

//⬜️⬛️⬛️⬛️⬛️⬜️⬜️⬜️⬜️⬛️⬛️⬜️⬜️⬛️⬛️⬛️⬛️⬜️⬜️⬛️⬜️⬛️⬛️⬛️⬜️
//⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬛️⬜️
//⬜️⬛️⬛️⬛️⬛️⬜️⬜️⬜️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️
//⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬜️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬜️⬛️⬛️
//⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬛️⬜️⬛️⬛️
//⬜️⬜️⬜️⬜️⬛️⬜️⬜️⬜️⬜️⬛️⬛️⬜️⬜️⬜️⬛️⬛️⬜️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️
