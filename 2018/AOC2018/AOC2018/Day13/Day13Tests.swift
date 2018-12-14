import XCTest
import AOC2018

class AOC2018_Day13_Tests: XCTestCase {
    let day = Day13()
    
    func testPart1() {
        XCTAssertEqual("TBD", day.part1())
    }
    
    // incorrect:
    //(You guessed 23,135)
    //(You guessed 19,6)
    //(You guessed 82,2)
    //(You guessed 83,2)
    //BOOM!: 82,104
    func testPart2() {
        XCTAssertEqual("TBD", day.part2())
        
        let path = NSTemporaryDirectory()
        let url = URL(fileURLWithPath: (path as NSString).appendingPathComponent("1-steps"))
        print("Writing to... \(url)")
        try! FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)

        (0..<100_000).forEach { step in
            //let newUrl = url.appendingPathComponent("step-\(step).txt")
            //try! day.printGrid().write(to: newUrl, atomically: true, encoding: .ascii)
//            if step == 402 {
//                day.printGrid()
//                print("now?")
//            }
            if let crash = day.step() {
                print("Crash at \(step):")
                print(crash)
            }
        }
    }
    
    func testGross1() {
        let testInput = """
        /->-\\
        |   |  /----\\
        | /-+--+-\\  |
        | | |  | v  |
        \\-+-/  \\-+--/
          \\------/
        """
        
        let day = Day13(input: testInput)
        
        let firstCart = day.carts.first!
        let lastCart = day.carts.last!
        
        XCTAssertEqual(firstCart.currentDirection, .right)
        XCTAssertEqual(firstCart.row, 0)
        XCTAssertEqual(firstCart.col, 2)
        XCTAssertEqual(lastCart.currentDirection, .down)
        XCTAssertEqual(lastCart.row, 3)
        XCTAssertEqual(lastCart.col, 9)

        day.step()
        XCTAssertEqual(firstCart.currentDirection, .right)
        XCTAssertEqual(firstCart.row, 0)
        XCTAssertEqual(firstCart.col, 3)
        XCTAssertEqual(lastCart.currentDirection, .right)
        XCTAssertEqual(lastCart.row, 4)
        XCTAssertEqual(lastCart.col, 9)

        day.step()
        XCTAssertEqual(firstCart.currentDirection, .down)
        XCTAssertEqual(firstCart.row, 0)
        XCTAssertEqual(firstCart.col, 4)
        XCTAssertEqual(lastCart.currentDirection, .right)
        XCTAssertEqual(lastCart.row, 4)
        XCTAssertEqual(lastCart.col, 10)

        day.step()
        XCTAssertEqual(firstCart.currentDirection, .down)
        XCTAssertEqual(firstCart.row, 1)
        XCTAssertEqual(firstCart.col, 4)
        
        day.step()
        XCTAssertEqual(firstCart.currentDirection, .right)
        XCTAssertEqual(firstCart.row, 2)
        XCTAssertEqual(firstCart.col, 4)

        day.step()
        XCTAssertEqual(firstCart.currentDirection, .right)
        XCTAssertEqual(firstCart.row, 2)
        XCTAssertEqual(firstCart.col, 5)

        day.step()
        XCTAssertEqual(firstCart.currentDirection, .right)
        XCTAssertEqual(firstCart.row, 2)
        XCTAssertEqual(firstCart.col, 6)

        day.step()
        XCTAssertEqual(firstCart.currentDirection, .right)
        XCTAssertEqual(firstCart.row, 2)
        XCTAssertEqual(firstCart.col, 7)

        day.step()
        XCTAssertEqual(firstCart.currentDirection, .right)
        XCTAssertEqual(firstCart.row, 2)
        XCTAssertEqual(firstCart.col, 8)

        day.step()
        XCTAssertEqual(firstCart.currentDirection, .down)
        XCTAssertEqual(firstCart.row, 2)
        XCTAssertEqual(firstCart.col, 9)

        day.step()
        XCTAssertEqual(firstCart.currentDirection, .down)
        XCTAssertEqual(firstCart.row, 3)
        XCTAssertEqual(firstCart.col, 9)

        XCTAssertNil(day.step())
        XCTAssertEqual(firstCart.currentDirection, .left)
        XCTAssertEqual(firstCart.row, 4)
        XCTAssertEqual(firstCart.col, 9)
        
        XCTAssertNil(day.step())
        XCTAssertEqual(firstCart.currentDirection, .left)
        XCTAssertEqual(firstCart.row, 4)
        XCTAssertEqual(firstCart.col, 8)
        
        XCTAssertNil(day.step())
        XCTAssertEqual(firstCart.currentDirection, .up)
        XCTAssertEqual(firstCart.row, 4)
        XCTAssertEqual(firstCart.col, 7)
        
        let crash = day.step()!
        XCTAssertEqual(firstCart.currentDirection, .up)
        XCTAssertEqual(firstCart.row, 3)
        XCTAssertEqual(firstCart.col, 7)
        XCTAssertEqual(lastCart.currentDirection, .down)
        XCTAssertEqual(lastCart.row, 3)
        XCTAssertEqual(lastCart.col, 7)
        
        XCTAssertEqual(crash.col, 7)
        XCTAssertEqual(crash.row, 3)
    }
    
    func testPart2Thing() {
        let testInput = """
        />-<\\
        |   |
        | /<+-\\
        | | | v
        \\>+</ |
          |   ^
          \\<->/
        """
        let day = Day13(input: testInput)

        (0..<20).forEach { step in
            day.step()
            day.printGrid()
        }
    }
}
