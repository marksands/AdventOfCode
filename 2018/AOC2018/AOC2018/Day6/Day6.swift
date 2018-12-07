import Foundation

public final class Day6: Day {
    private let points: [CGPoint] = Input().trimmedInputCharactersByNewlines()
        .map { $0.components(separatedBy: ", ").compactMap(Int.init) }
        .map { CGPoint(x: $0.first!, y: $0.last!) }
    
    public override func part1() -> String {
        let topLeft = points.min(by: { p1, p2 in p1.x < p2.x || p1.y < p2.y })!
        let bottomRight = points.max(by: { p1, p2 in p1.x < p2.x || p1.y < p2.y })!
        
        let width = Int(bottomRight.x - topLeft.x)
        let height = Int(bottomRight.y - topLeft.y)

        var grid = (0...width).map { _ in // row
            (0...height).map { _ in // col
                return "."
            }
        }
        
        zip(points.indices, points).forEach { arg in
            let (index, coord) = arg
            grid[Int(coord.x)-1][Int(coord.y)-1] = "\(index+1)"
        }
        
        grid.forEach { col in
            var r = ""
            col.forEach { row in
                r += row
            }
            print(r)
        }
        
        return "TBD"
    }
    
    public override func part2() -> String {
        return super.part2()
    }
}
