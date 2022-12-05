import Foundation
import AdventOfCode

public final class Day5: Day {
    private let lines: [String]

//    [N]             [R]             [C]
//    [T] [J]         [S] [J]         [N]
//    [B] [Z]     [H] [M] [Z]         [D]
//    [S] [P]     [G] [L] [H] [Z]     [T]
//    [Q] [D]     [F] [D] [V] [L] [S] [M]
//    [H] [F] [V] [J] [C] [W] [P] [W] [L]
//    [G] [S] [H] [Z] [Z] [T] [F] [V] [H]
//    [R] [H] [Z] [M] [T] [M] [T] [Q] [W]
//     1   2   3   4   5   6   7   8   9

    var cranes: [[String]] = [
        ["R", "G", "H", "Q", "S", "B", "T", "N"],
        ["H", "S", "F", "D", "P", "Z", "J"],
        ["Z", "H", "V"],
        ["M", "Z", "J", "F", "G", "H"],
        ["T", "Z", "C", "D", "L", "M", "S", "R"],
        ["M", "T", "W", "V", "H", "Z", "J"],
        ["T", "F", "P", "L", "Z"],
        ["Q", "V", "W", "S"],
        ["W", "H", "L", "M", "T", "D", "N", "C"]

    ]

    public init(rawInput: [String] = Input().trimmedInputCharactersByNewlines()) {
        self.lines = rawInput
        super.init()
    }

    public override func part1() -> String {
        for line in lines {
            let args = line.ints
            for _ in (0..<(args[0])) {
                let top = cranes[args[1]-1].popLast()!
                cranes[args[2]-1].append(top)
            }
        }
        return cranes.reduce(into: "", { $0 += $1.last! })
    }

    public override func part2() -> String {
        for line in lines {
            let args = line.ints
            let lowerBound = (cranes[args[1]-1].count - args[0])
            let upperBound = cranes[args[1]-1].count
            let topSlice = cranes[args[1]-1][lowerBound..<upperBound]
            cranes[args[2]-1].append(contentsOf: topSlice)
            cranes[args[1]-1].removeLast(args[0])
        }
        return cranes.reduce(into: "", { $0 += $1.last! })
    }
}
