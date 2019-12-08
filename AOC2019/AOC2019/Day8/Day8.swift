import Foundation
import AdventOfCode

public final class Day8: Day {
    private let input = Input().trimmedRawInput()
    
    public override func part1() -> String {
        let fewestZeros = Array(input).chunks(ofSize: 25 * 6)
            .min(by: { $0.count { $0 == "0" } < $1.count { $0 == "0" } })!
        
        return String(fewestZeros.count { String($0) == "1" } * fewestZeros.count { String($0) == "2" })
    }
    
    public override func part2() -> String {
        var picture = Array(repeating: "2", count: 25 * 6)
        
        Array(input).chunks(ofSize: 25 * 6).forEach { layer in
            picture = zip(picture, layer).map { p, l -> String in
                p == "2" ? String(l) : p
            }
        }
        
        printPicture(picture)
                
        return ""
    }
    
    private func printPicture(_ picture: [String]) {
        picture.chunks(ofSize: 25).forEach { y in
            var result = ""
            y.forEach { x in
                if x == "1" {
                    result += "⬜️"
                } else {
                    result += "⬛️"
                }
            }
            print(result)
        }
    }
}

//⬜️⬛️⬛️⬛️⬛️⬜️⬜️⬜️⬜️⬛️⬛️⬜️⬜️⬛️⬛️⬛️⬛️⬜️⬜️⬛️⬜️⬛️⬛️⬛️⬜️
//⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬛️⬜️
//⬜️⬛️⬛️⬛️⬛️⬜️⬜️⬜️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️
//⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬜️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬜️⬛️⬛️
//⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬛️⬜️⬛️⬛️
//⬜️⬜️⬜️⬜️⬛️⬜️⬜️⬜️⬜️⬛️⬛️⬜️⬜️⬜️⬛️⬛️⬜️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️
