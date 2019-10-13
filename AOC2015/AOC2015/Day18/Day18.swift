import Foundation
import AdventOfCode

public final class Day18: Day {
    struct Board {
        var grid: [[String]] = []
        
        mutating func cycle(shouldEnableCorners: Bool = false) {
            if shouldEnableCorners { enableCorners() }
            defer { if shouldEnableCorners { enableCorners() } }
            
            var copy = grid
            
            CGRect(origin: .zero, size: CGSize(width: 99, height: 99))
                .allPositionsMatrix()
                .forEach { row in
                    row.forEach { position in
                        let count = countOfOnNeighbors(at: position.x, position.y)
                        
                        if grid[position.x][position.y] == "#" {
                            if count < 2 || count > 3 {
                                copy[position.x][position.y] = "."
                            }
                        } else {
                            if count == 3 {
                                copy[position.x][position.y] = "#"
                            }
                        }
                    }
                }
            
            grid = copy
        }
        
        mutating func enableCorners() {
            CGRect(origin: .zero, size: CGSize(width: 99, height: 99))
                .corners()
                .forEach { position in
                    grid[position.x][position.y] = "#"
                }
        }
        
        func countOfAllOnNodes() -> Int {
            return grid.reduce(0) {
                $0 + $1.reduce(0) {
                    $0 + $1.count(where: { String($0) == "#" })
                }
            }
        }
        
        func countOfOnNeighbors(at x: Int, _ y: Int) -> Int {
            return Position(x: x, y: y).surrounding()
                .compactMap { grid[safe: $0.x]?[safe: $0.y] }
                .count(where: { $0 == "#" })
        }
    }
    
    var board = Board()
    
    public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
        board.grid = input.map { $0.map(String.init) }
        super.init()
    }

    public override func part1() -> String {
        (0..<100).forEach { _ in
            board.cycle()
        }
        return "\(board.countOfAllOnNodes())"
    }
    
    public override func part2() -> String {
        (0..<100).forEach { _ in
            board.cycle(shouldEnableCorners: true)
        }
        return "\(board.countOfAllOnNodes())"
    }
}
