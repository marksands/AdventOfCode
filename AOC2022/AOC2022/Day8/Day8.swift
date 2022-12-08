import Foundation
import AdventOfCode

public final class Day8: Day {
    private let lines: [String]

    var grid: [[Int]] = []
    var height = 0
    var width = 0

    public init(rawInput: [String] = Input().trimmedInputCharactersByNewlines()) {
        self.lines = rawInput
        super.init()

        for line in lines {
            var row: [Int] = []
            for char in line {
                row.append(String(char).int)
            }
            grid.append(row)
        }

        height = grid.count
        width = grid[0].count
    }

    public override func part1() -> String {
        return run().part1
    }

    public override func part2() -> String {
        return run().part2
    }

    private func run() -> (part1: String, part2: String) {
        var visibleCount = 0
        visibleCount = width * 2 // top and bottom
        visibleCount += (height * 2)-4 // height minus top and bottoms

        var maxScore = 0

        for (y, row) in grid.enumerated() {
            if y == 0 || y == height-1 { continue }
            for (x, _) in row.enumerated() {
                if x == 0 || x == width-1 { continue }
                let position = Position(x: x, y: y)

                let (vis, score) = visibilityAndScenicScore(from: position, in: grid)
                maxScore = max(maxScore, score)
                if vis { visibleCount += 1 }
            }
        }

        return (visibleCount.string, maxScore.string)
    }

    private func visibilityAndScenicScore(from position: Position, in grid: [[Int]]) -> (Bool, Int) {
        let current = grid[position.y][position.x]
        var eastScore = 0, westScore = 0, northScore = 0, southScore = 0
        let east = grid.firstWhile(from: position, along: Position.zero.east(), { v in
            eastScore += 1
            return v < current
        })
        let west = grid.firstWhile(from: position, along: Position.zero.west(), { v in
            westScore += 1
            return v < current
        })
        let north = grid.firstWhile(from: position, along: Position.zero.north(), { v in
            northScore += 1
            return v < current
        })
        let south = grid.firstWhile(from: position, along: Position.zero.south(), { v in
            southScore += 1
            return v < current
        })
        let visibility = east == nil || west == nil || north == nil || south == nil
        let score = eastScore * westScore * northScore * southScore
        return (visibility, score)
    }
}
