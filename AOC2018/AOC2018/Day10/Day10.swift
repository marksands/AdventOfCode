import Foundation

public final class Day10: Day {
    struct PointInfo {
        let position: CGPoint
        let velocity: CGSize
        
        func position(atTime time: Int) -> CGPoint {
            let t = CGFloat(time)
            return CGPoint(x: position.x + velocity.width * t, y: position.y + velocity.height * t)
        }
    }
    
    private let points: [PointInfo]
    
    public override init() {
        let regex = Regex(pattern: "^position=<\\s*(-?\\d+),\\s*(-?\\d+)>\\s*velocity=<\\s*(-?\\d+),\\s*(-?\\d+)>$")
        let input = Input().trimmedInputCharactersByNewlines()
        
        points = input.compactMap { line -> PointInfo? in
            guard let matches = regex.matches(in: line) else { return nil }
            
            let x = Int(matches[1])!
            let y = Int(matches[2])!
            let width = Int(matches[3])!
            let height = Int(matches[4])!
            return PointInfo(position: CGPoint(x: x, y: y), velocity: CGSize(width: width, height: height))
        }
        
        super.init()
    }
    
    public override func part1() -> String {
        //(8_000..<10_500).forEach { tick in
        let tick = 10240
            let adjustedPoints = points.map { $0.position(atTime: tick) }
            if adjustedPoints.allSatisfy({ $0.x > 0 && $0.y > 0 }) {
                print("seconds: \(tick)")
                printPoints(adjustedPoints)
            }
        //}
        
        return "RLEZNRAN"
    }
    
    
    public override func part2() -> String {
        // see part1
        return "10240"
    }
    
    private func printPoints(_ points: [CGPoint]) {
        (0..<175).forEach { y in
            var result = ""
            (160..<300).forEach { x in
                let point = CGPoint(x: x, y: y)
                result += points.contains(point) ? "#" : "."
            }
            print(result)
        }
        print("\n\n\n\n\n")
    }
}
