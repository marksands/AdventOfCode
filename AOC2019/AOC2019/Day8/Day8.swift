import Foundation
import AdventOfCode

public final class Day8: Day {
    public override func part1() -> String {
        let input = Input().trimmedRawInput()
        
        var min = Int.max
        var array: [String] = []
        
        Array(input).chunks(ofSize: 25 * 6).forEach { layer in
            let c = layer.count(where: { String($0) == "0" })
            if c < min {
                min = c
                array = layer.map(String.init)
            }
        }
        
        return String(array.count(where: { String($0) == "1" }) * array.count(where: { String($0) == "2" }))
    }
    
    public override func part2() -> String {
        let input = Input().trimmedRawInput()
        var picture = Array(repeating: Array(repeating: "2", count: 25), count: 6)
        
        Array(input).chunks(ofSize: 25 * 6).forEach { layer in
            for (i, row) in layer.chunks(ofSize: 25).enumerated() {
                for (j, col) in row.enumerated() {
                    if picture[i][j] == "2" {
                        picture[i][j] = String(col)
                    }
                }
            }
        }
        
        func printPicture(_ picture: [[String]]) {
            (0..<6).forEach { y in
                var result = ""
                (0..<25).forEach { x in
                    if picture[y][x] == "1" {
                        result += "X"
                    } else {
                        result += " "
                    }
                }
                print(result)
            }
            print("\n\n\n\n\n")
        }
        
        printPicture(picture)
        
        return ""
    }
}

//X    XXXX  XX    XX X   X
//X    X    X  X    X X   X
//X    XXX  X       X  X X
//X    X    X XX    X   X
//X    X    X  X X  X   X
//XXXX XXXX  XXX  XX    X
