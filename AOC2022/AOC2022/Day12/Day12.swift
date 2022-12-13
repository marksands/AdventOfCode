import Foundation
import AdventOfCode

public final class Day12: Day {
    private let input: String

    public init(rawInput: String = Input().trimmedRawInput()) {
        self.input = rawInput
        super.init()
    }

    public override func part1() -> String {
        var grid: [Position: Int] = [:]

        var table: [String: Int] = [:]
        for (i, c) in lowercaseLetters.exploded().enumerated() {
            table[c] = i
        }
        table["S"] = 0
        table["E"] = 25

        var startingPosition: Position!
        var endPosition: Position!

        for (row, line) in input.lines.enumerated() {
            for (col, c) in line.exploded().enumerated() {
                if c == "S" {
                    startingPosition = Position(x: col, y: row)
                }
                if c == "E" {
                    endPosition = Position(x: col, y: row)
                }
                grid[Position(x: col, y: row)] = table[c]!
            }
        }

        let sortOrder = { (lhs: (Int, Position), rhs: (Int, Position)) in
            (lhs.0, lhs.1.manhattanDistance(to: endPosition)) < (rhs.0, rhs.1.manhattanDistance(to: endPosition))
        }

        var queue = PriorityQueue<(Int, Position)>(sort: sortOrder)
        queue.enqueue((1, startingPosition))

        var visited: Set<Position> = [startingPosition]

        while queue.count > 0 {
            let top = queue.dequeue()!

            if top.1 == endPosition {
                return (top.0 - 1).string
            }

            for neighbor in neighbors(grid, cur: top) {
                guard !visited.contains(neighbor) else { continue }
                queue.enqueue((top.0 + 1, neighbor))
                visited.insert(neighbor)
            }
        }

        return ""
    }

    private func neighbors(_ grid: [Position: Int], cur: (Int, Position)) -> [Position] {
        return cur.1
            .adjacent(withinGrid: grid)
            .filter {
                (grid[$0]! > grid[cur.1]! && (grid[$0]! - grid[cur.1]! == 1)) ||
                (grid[$0]! <= grid[cur.1]!)
            }
    }

    public override func part2() -> String {
        var grid: [Position: Int] = [:]

        var table: [String: Int] = [:]
        for (i, c) in lowercaseLetters.exploded().enumerated() {
            table[c] = i
        }
        table["S"] = 0
        table["E"] = 25

        var endPosition: Position!

        for (row, line) in input.lines.enumerated() {
            for (col, c) in line.exploded().enumerated() {
                if c == "E" {
                    endPosition = Position(x: col, y: row)
                }
                grid[Position(x: col, y: row)] = table[c]!
            }
        }

        let sortOrder = { (lhs: (Int, Position), rhs: (Int, Position)) in
            (lhs.0, lhs.1.manhattanDistance(to: endPosition)) < (rhs.0, rhs.1.manhattanDistance(to: endPosition))
        }

        let allPossibleStartingPositions: [Position] = grid.filter { $0.value == 0 }.map { $0.key }

        var minSteps = Int.max

        for start in allPossibleStartingPositions {
            var queue = PriorityQueue<(Int, Position)>(sort: sortOrder)
            queue.enqueue((1, start))

            var visited: Set<Position> = [start]

            while queue.count > 0 {
                let top = queue.dequeue()!

                if top.1 == endPosition {
                    let steps = (top.0 - 1)
                    minSteps = min(minSteps, steps)
                    break
                }

                for neighbor in neighbors(grid, cur: top) {
                    guard !visited.contains(neighbor) else { continue }
                    queue.enqueue((top.0 + 1, neighbor))
                    visited.insert(neighbor)
                }
            }
        }

        return minSteps.string
    }
}
