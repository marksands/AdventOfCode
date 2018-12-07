import XCTest
import AOC2018

public final class Grid {
    public let grid: [[String]]
    
    public let points: [CGPoint]
    public let remainingPoints: [CGPoint]
    
    private let width: Int
    private let height: Int
    
    public init(points: [CGPoint]) {
        let maxX = Int(points.reduce(CGFloat.leastNormalMagnitude) { max($0, $1.x) })
        let minX = 0//points.reduce(CGFloat.greatestFiniteMagnitude) { min($0, $1.x) }
        let maxY = Int(points.reduce(CGFloat.leastNormalMagnitude) { max($0, $1.y) })
        let minY = 0//points.reduce(CGFloat.greatestFiniteMagnitude) { min($0, $1.y) }

        let width = maxX - minX
        let height = maxY - minY
        self.points = points

        grid = (0...height).map { _ in
            (0...width).map { _ in
                return "."
            }
        }
        self.width = width
        self.height = height
        
        remainingPoints = zip(grid.indices, grid).flatMap { arg in
            zip(arg.1.indices, arg.1).map { arg2 -> CGPoint in
                CGPoint(x: arg2.0, y: arg.0)
            }
        }.filter { !points.contains($0) }
    }
    
    public func manhattenDistance(from p1: CGPoint, to p2: CGPoint) -> Int {
        return abs(Int(p1.y - p2.y)) + abs(Int(p1.x - p2.x))
    }
    
    var ownedPoints: [String: [CGPoint]] = [:]
    var finitePoints: [String: [CGPoint]] = [:]
    var tiedTiles: [CGPoint] = []
    
    let possibleKeys = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()-+={}[]<>©®†™ßœ∑¨π˜µ"
    
    private func keyForPoint(_ point: CGPoint) -> String? {
        return points.firstIndex(of: point).map { possibleKeys.exploded()[$0] }
        ///return points.firstIndex(of: point).map { uppercaseLetters.exploded()[$0] }//String(UnicodeScalar(UInt8($0))) }
    }
    
    public func computePart1() {
        remainingPoints.forEach { point in
            let scores = points.map { manhattenDistance(from: point, to: $0) }
            if scores.countElements()[scores.min()!] == 1 {
                let firstPoint = points.sorted { manhattenDistance(from: point, to: $0) < manhattenDistance(from: point, to: $1) }.first!
                ownedPoints[keyForPoint(firstPoint)!, default: []] += [point]
            }
        }
        let maxKey = ownedPoints.sorted { (a1, a2) -> Bool in a1.1.count > a2.1.count }.first?.key
        print("max: \(maxKey!) - count: \(ownedPoints[maxKey!]?.count)")
        tiedTiles = remainingPoints.filter { !ownedPoints.values.flatMap { $0 }.contains($0) }
        
        /// Remove Boundary!
        zip(Array(repeating: 0, count: height), (0...height)).forEach { x, y in
            let point = CGPoint(x: x, y: y)
            if let entryKey = ownedPoints.first(where: { $0.value.contains(point) })?.key {
                ownedPoints.removeValue(forKey: entryKey)
            }
        }

        zip(Array(repeating: width, count: height), (0...height)).forEach { x, y in
            let point = CGPoint(x: x, y: y)
            if let entryKey = ownedPoints.first(where: { $0.value.contains(point) })?.key {
                ownedPoints.removeValue(forKey: entryKey)
            }
        }

        zip((0...width), Array(repeating: 0, count: width)).forEach { x, y in
            let point = CGPoint(x: x, y: y)
            if let entryKey = ownedPoints.first(where: { $0.value.contains(point) })?.key {
                ownedPoints.removeValue(forKey: entryKey)
            }
        }

        zip((0...width), Array(repeating: height, count: width)).forEach { x, y in
            let point = CGPoint(x: x, y: y)
            if let entryKey = ownedPoints.first(where: { $0.value.contains(point) })?.key {
                ownedPoints.removeValue(forKey: entryKey)
            }
        }
        
        print(ownedPoints.mapValues { $0.count }.sorted { $0.value < $1.value }) // and add 1

//        (0...height).forEach { y in
//            (0...width).forEach { x in
//                print("\(x), \(y)")
//            }
//        }
    }
    
    public func computePart2() -> Int {
        return (points + remainingPoints).reduce(0) { seed, point in
            let scores = points.map { manhattenDistance(from: point, to: $0) }.reduce(0, +)
            if scores < 10000 {
                return seed + 1
            }
            return seed
        }
    }
    
    func printGrid() {
        zip(grid.indices, grid).forEach { arg in
            var result = ""
            zip(arg.1.indices, arg.1).forEach { arg2 in
                let point = CGPoint(x: arg2.0, y: arg.0)
                if tiedTiles.contains(point) {
                    result += "."
                } else if let thePointKey = ownedPoints.first(where: { return $0.1.contains(point) })?.key {
                    result += thePointKey//.lowercased()
                } else {
                    if let key = keyForPoint(point) {
                        result += key
                    } else {
                        //print("? -> \(point)")
                        result += "."//"?"
                    }
                }
            }
            print(result)
        }
    }
}

class AOC2018_Day6_Tests: XCTestCase {
    let day = Day6()
    
//    func testPart1() {
//        XCTAssertEqual("TBD", day.part1())
//    }
//
//    func testPart2() {
//        XCTAssertEqual("TBD", day.part2())
//    }
    
    // [".", ".", "A", ".", "."],
    // [".", ".", "X", ".", "."],
    // [".", "C", "D", "B", "."],
    // [".", "c", ".", ".", "."],
    // [".", ".", ".", ".", "Y"]
    let aPoint = CGPoint(x: 2, y: 0)
    let bPoint = CGPoint(x: 3, y: 2)
    let cPoint = CGPoint(x: 1, y: 2)
    let dPoint = CGPoint(x: 2, y: 2)
    let xPoint = CGPoint(x: 2, y: 1)
    let yPoint = CGPoint(x: 4, y: 4)

    var grid: Grid!
    
    func testMD1() {
        grid = Grid(points: [aPoint, bPoint])

        let distance = grid.manhattenDistance(from: xPoint, to: xPoint)
        XCTAssertEqual(0, distance)
    }
    
    func testMD2() {
        grid = Grid(points: [aPoint, bPoint])

        var distance = grid.manhattenDistance(from: xPoint, to: aPoint)
        XCTAssertEqual(1, distance)

        distance = grid.manhattenDistance(from: xPoint, to: dPoint)
        XCTAssertEqual(1, distance)

        distance = grid.manhattenDistance(from: cPoint, to: bPoint)
        XCTAssertEqual(2, distance)

        distance = grid.manhattenDistance(from: bPoint, to: cPoint)
        XCTAssertEqual(2, distance)
    }
    
    func testMD3() {
        grid = Grid(points: [aPoint, bPoint])

        var distance = grid.manhattenDistance(from: xPoint, to: yPoint)
        XCTAssertEqual(5, distance)

        distance = grid.manhattenDistance(from: cPoint, to: yPoint)
        XCTAssertEqual(5, distance)
        
        distance = grid.manhattenDistance(from: yPoint, to: xPoint)
        XCTAssertEqual(5, distance)
        
        distance = grid.manhattenDistance(from: yPoint, to: cPoint)
        XCTAssertEqual(5, distance)

        distance = grid.manhattenDistance(from: yPoint, to: bPoint)
        XCTAssertEqual(3, distance)
        
        distance = grid.manhattenDistance(from: bPoint, to: yPoint)
        XCTAssertEqual(3, distance)
    }
    
    func testMD4() {
        // ["A", ".", "b", "B"]
        // [".", "D", "d", "b"]
        // ["c", "d", ".", "e"]
        // ["C", "c", "e", "E"]
        let grid = Grid(points: [CGPoint(x: 0, y: 0), CGPoint(x: 3, y: 0), CGPoint(x: 0, y: 3), CGPoint(x: 1, y: 1), CGPoint(x: 3, y: 3)])

        var distance = grid.manhattenDistance(from: CGPoint(x: 1, y: 0), to: CGPoint(x: 1, y: 1))
        XCTAssertEqual(1, distance)

        distance = grid.manhattenDistance(from: CGPoint(x: 1, y: 1), to: CGPoint(x: 1, y: 0))
        XCTAssertEqual(1, distance)

        distance = grid.manhattenDistance(from: CGPoint(x: 1, y: 0), to: CGPoint(x: 0, y: 3))
        XCTAssertEqual(4, distance)

        distance = grid.manhattenDistance(from: CGPoint(x: 0, y: 3), to: CGPoint(x: 1, y: 0))
        XCTAssertEqual(4, distance)
    }
    
    func testRP1() {
        // ["A", "."]
        // [".", "B"]
        let grid = Grid(points: [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1)])
        XCTAssertEqual([CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1)], grid.remainingPoints)
    }
    
    func testRP2() {
        // ["A", ".", ".", "C"]
        // [".", ".", ".", "."]
        // [".", ".", ".", "."]
        // [".", "B", ".", "."]
        let grid = Grid(points: [CGPoint(x: 0, y: 0), CGPoint(x: 3, y: 0), CGPoint(x: 1, y: 3)])
        
        let remaining = [
            CGPoint(x: 1, y: 0), CGPoint(x: 2, y: 0),
            CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 2, y: 1), CGPoint(x: 3, y: 1),
            CGPoint(x: 0, y: 2), CGPoint(x: 1, y: 2), CGPoint(x: 2, y: 2), CGPoint(x: 3, y: 2),
            CGPoint(x: 0, y: 3), CGPoint(x: 2, y: 3), CGPoint(x: 3, y: 3)
        ]
        XCTAssertEqual(remaining, grid.remainingPoints)
    }
    
    func testRP3() {
        // ["A", "B", ".", "D"]
        // [".", "F", ".", "G"]
        let grid = Grid(points: [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), CGPoint(x: 3, y: 0), CGPoint(x: 1, y: 1), CGPoint(x: 3, y: 1)])
        
        let remaining = [CGPoint(x: 2, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 2, y: 1)]
        XCTAssertEqual(remaining, grid.remainingPoints)
    }

    func testTiedTiles() {
        // ["A", ".", "b", "B"]
        // [".", "D", "d", "b"]
        // ["c", "d", ".", "e"]
        // ["C", "c", "e", "E"]
        let grid = Grid(points: [CGPoint(x: 0, y: 0), CGPoint(x: 3, y: 0), CGPoint(x: 0, y: 3), CGPoint(x: 1, y: 1), CGPoint(x: 3, y: 3)])
        grid.computePart1()
        
        let leftoverTiles = grid.tiedTiles
        XCTAssertEqual([CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 2, y: 2)], leftoverTiles)
    }
    
    func testTiedTiles2() {
        // ["A", "a", "a", "a", "a", "b", "b", "b"]
        // ["a", "a", "c", "c", ".", "b", "b", "b"]
        // ["a", "c", "c", "c", ".", "b", "b", "B"]
        // ["c", "c", "C", "c", "c", ".", "b", "b"]
        let grid = Grid(points: [CGPoint(x: 0, y: 0), CGPoint(x: 7, y: 2), CGPoint(x: 2, y: 3)])
        grid.computePart1()
        
        let leftoverTiles = grid.tiedTiles
        XCTAssertEqual([CGPoint(x: 4, y: 1), CGPoint(x: 4, y: 2), CGPoint(x: 5, y: 3)], leftoverTiles)
        
//        ownedTiles Dictionary:
//        AAAAAAAAAA  (1.0, 0.0), (2.0, 0.0), (3.0, 0.0), (4.0, 0.0), (5.0, 0.0), (6.0, 0.0), (7.0, 0.0),
//        (0.0, 1.0), (1.0, 1.0), (2.0, 1.0), (3.0, 1.0),     .       (5.0, 1.0), (6.0, 1.0), (7.0, 1.0),
//        (0.0, 2.0), (1.0, 2.0), (2.0, 2.0), (3.0, 2.0),     .       (5.0, 2.0), (6.0, 2.0), BBBBBBBBBB
//        (0.0, 3.0), (1.0, 3.0),  CCCCCCCCC  (3.0, 3.0), (4.0, 3.0),      .      (6.0, 3.0), (7.0, 3.0)
    }
    
    func testDemo1_1() {
        let points = [
            CGPoint(x: 1, y: 1),
            CGPoint(x: 8, y: 3),
            CGPoint(x: 3, y: 4),
            CGPoint(x: 5, y: 5),
            CGPoint(x: 1, y: 6),
        ]
        let grid = Grid(points: points)
        
        // FIXME: I need to account for over-the-edge boundaries?
        grid.computePart1()
        grid.printGrid()
    }
    
    func testDemo1_part2() {
        let points = [
            CGPoint(x: 1, y: 1),
            CGPoint(x: 1, y: 6),
            CGPoint(x: 8, y: 3),
            CGPoint(x: 3, y: 4),
            CGPoint(x: 5, y: 5),
            CGPoint(x: 8, y: 9)
            ]
        let grid = Grid(points: points)
        
        // FIXME: I need to account for over-the-edge boundaries?
        grid.computePart1()
        grid.printGrid()
    }
    
    func testDemo1_2() {
        let input = """
156, 193
81, 315
50, 197
84, 234
124, 162
339, 345
259, 146
240, 350
97, 310
202, 119
188, 331
199, 211
117, 348
350, 169
131, 355
71, 107
214, 232
312, 282
131, 108
224, 103
83, 122
352, 142
208, 203
319, 217
224, 207
327, 174
89, 332
254, 181
113, 117
120, 161
322, 43
115, 226
324, 222
151, 240
248, 184
207, 136
41, 169
63, 78
286, 43
84, 222
81, 167
128, 192
127, 346
213, 102
313, 319
207, 134
154, 253
50, 313
160, 330
332, 163
"""
        let points = input.components(separatedBy: .newlines)
            .compactMap { $0.components(separatedBy: ", ").compactMap(Int.init) }
            .map { CGPoint(x: $0[0], y: $0[1]) }

        // 4342 is the answer!
        // 5004 is too high :thinking:
        let grid = Grid(points: points)
        grid.computePart1()
    }
    
    func testPart2() {
        let input = """
156, 193
81, 315
50, 197
84, 234
124, 162
339, 345
259, 146
240, 350
97, 310
202, 119
188, 331
199, 211
117, 348
350, 169
131, 355
71, 107
214, 232
312, 282
131, 108
224, 103
83, 122
352, 142
208, 203
319, 217
224, 207
327, 174
89, 332
254, 181
113, 117
120, 161
322, 43
115, 226
324, 222
151, 240
248, 184
207, 136
41, 169
63, 78
286, 43
84, 222
81, 167
128, 192
127, 346
213, 102
313, 319
207, 134
154, 253
50, 313
160, 330
332, 163
"""
        let points = input.components(separatedBy: .newlines)
            .compactMap { $0.components(separatedBy: ", ").compactMap(Int.init) }
            .map { CGPoint(x: $0[0], y: $0[1]) }
        
        let grid = Grid(points: points)

        // 42966!!111
        let value = grid.computePart2()
        print("region: \(value)")
    }
}
