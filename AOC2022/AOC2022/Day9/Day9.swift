import Foundation
import AdventOfCode

public final class Day9: Day {
    private let lines: [String]

    public init(rawInput: [String] = Input().trimmedInputCharactersByNewlines()) {
        self.lines = rawInput
        super.init()
    }

    public override func part1() -> String {
        var head: Position = .zero
        var tail: Position = .zero

        var positions: Set<Position> = []
        positions.insert(tail)

        for line in lines {
            let parts = line.components(separatedBy: " ")
            let move = parts[0]
            let count = parts[1].int

            if move == "U" {
                for _ in (0..<count) {
                    head = head.advanced(toward: .north)
                    checkAndMoveTail(tailPos: tail, headPos: head, direction: .north, { newTail in
                        tail = newTail
                        positions.insert(tail)
                    })
                }
            } else if move == "D" {
                for _ in (0..<count) {
                    head = head.advanced(toward: .south)
                    checkAndMoveTail(tailPos: tail, headPos: head, direction: .south, { newTail in
                        tail = newTail
                        positions.insert(tail)
                    })
                }
            } else if move == "L" {
                for _ in (0..<count) {
                    head = head.advanced(toward: .west)
                    checkAndMoveTail(tailPos: tail, headPos: head, direction: .west, { newTail in
                        tail = newTail
                        positions.insert(tail)
                    })
                }

            } else if move == "R" {
                for _ in (0..<count) {
                    head = head.advanced(toward: .east)
                    checkAndMoveTail(tailPos: tail, headPos: head, direction: .east, { newTail in
                        tail = newTail
                        positions.insert(tail)
                    })
                }

            }
        }

        return positions.count.string
    }

    private func shouldTailMove(tailPos: Position, headPos: Position) -> Bool {
        if headPos.surroundingIncludingSelf().contains(tailPos) {
            return false
        }
        return true
    }

    private func checkAndMoveTail(tailPos: Position, headPos: Position, direction: Heading, _ cls: (Position) -> ()) {
        if headPos.surroundingIncludingSelf().contains(tailPos) { return }

        if headPos.y != tailPos.y && headPos.x != tailPos.x {
            if headPos.y < tailPos.y && headPos.x < tailPos.x {
                cls(tailPos.advanced(toward: .north).advanced(toward: .west))
            } else if headPos.y > tailPos.y && headPos.x < tailPos.x {
                cls(tailPos.advanced(toward: .south).advanced(toward: .west))
            } else if headPos.y < tailPos.y && headPos.x > tailPos.x {
                cls(tailPos.advanced(toward: .north).advanced(toward: .east))
            } else if headPos.y > tailPos.y && headPos.x > tailPos.x {
                cls(tailPos.advanced(toward: .south).advanced(toward: .east))
            }
        } else {
            if headPos.y == tailPos.y {
                if headPos.x < tailPos.x {
                    cls(tailPos.advanced(toward: .west))
                } else if headPos.x > tailPos.x {
                    cls(tailPos.advanced(toward: .east))
                }
            } else if headPos.x == tailPos.x {
                if headPos.y < tailPos.y {
                    cls(tailPos.advanced(toward: .north))
                } else if headPos.y > tailPos.y {
                    cls(tailPos.advanced(toward: .south))
                }
            }
            // cannot use the head as the heading, since direction can be different between knots!
            //cls(tailPos.advanced(toward: direction))
        }
    }

    public override func part2() -> String {
        var head: Position = .zero
        var tails = Array(repeating: Position.zero, count: 9)

        var positions: Set<Position> = []
        positions.insert(tails[8])

        for line in lines {
            let parts = line.components(separatedBy: " ")
            let move = parts[0]
            let count = parts[1].int
            if move == "U" {
                for _ in (0..<count) {
                    head = head.advanced(toward: .north)
                    for t in (0...8) {
                        let h = t == 0 ? head : tails[t-1]
                        let tl = tails[t]
                        checkAndMoveTail(tailPos: tl, headPos: h, direction: .north, { newTail in
                            tails[t] = newTail
                            if t == 8 {
                                positions.insert(tails[8])
                            }
                        })
                    }
                    printGrid(allPositions: [head] + tails)
                }
            } else if move == "D" {
                for _ in (0..<count) {
                    head = head.advanced(toward: .south)
                    for t in (0...8) {
                        let h = t == 0 ? head : tails[t-1]
                        let tl = tails[t]
                        checkAndMoveTail(tailPos: tl, headPos: h, direction: .south, { newTail in
                            tails[t] = newTail
                            if t == 8 {
                                positions.insert(tails[8])
                            }
                        })
                    }
                    printGrid(allPositions: [head] + tails)
                }
            } else if move == "L" {
                for _ in (0..<count) {
                    head = head.advanced(toward: .west)
                    for t in (0...8) {
                        let h = t == 0 ? head : tails[t-1]
                        let tl = tails[t]
                        checkAndMoveTail(tailPos: tl, headPos: h, direction: .west, { newTail in
                            tails[t] = newTail
                            if t == 8 {
                                positions.insert(tails[8])
                            }
                        })
                    }
                    printGrid(allPositions: [head] + tails)
                }
            } else if move == "R" {
                for _ in (0..<count) {
                    head = head.advanced(toward: .east)
                    for t in (0...8) {
                        let h = t == 0 ? head : tails[t-1]
                        let tl = tails[t]
                        checkAndMoveTail(tailPos: tl, headPos: h, direction: .east, { newTail in
                            tails[t] = newTail
                            if t == 8 {
                                positions.insert(tails[8])
                            }
                        })
                    }
                    printGrid(allPositions: [head] + tails)
                }
            }
        }

        return positions.count.string
    }

    private func printGrid(allPositions: [Position]) {
        return
        var result = ""
        for y in (-15...15) {
            for x in (-15...15) {
                let p = Position(x: x, y: y)
                if allPositions.contains(p) {
                    result += allPositions.firstIndex(where: { $0 == p })!.string
                } else {
                    result += "."
                }
            }
            result += "\n"
        }
        print(result)
    }
}
