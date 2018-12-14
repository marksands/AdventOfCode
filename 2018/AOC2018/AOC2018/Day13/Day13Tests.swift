import XCTest
import AOC2018

class AOC2018_Day13_Tests: XCTestCase {
    func testPart1() {
        let day = Day13()
        
        var tick: (crash: CGPoint?, carts: [Cart]) = (nil, day.carts)
        
        while tick.crash == nil {
            tick = day.step()
        }
        
        XCTAssertEqual("82,104", "\(Int(tick.crash!.x)),\(Int(tick.crash!.y))")
    }
    
    func testPart2() {
        let day = Day13()

        var tick: (crash: CGPoint?, carts: [Cart]) = (nil, day.carts)
        
        while tick.carts.count > 1 {
            tick = day.step()
        }
        
        XCTAssertEqual("121,22", "\(tick.carts[0].col),\(tick.carts[0].row)")
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

        day.step()
        XCTAssertEqual(firstCart.currentDirection, .left)
        XCTAssertEqual(firstCart.row, 4)
        XCTAssertEqual(firstCart.col, 9)
        
        day.step()
        XCTAssertEqual(firstCart.currentDirection, .left)
        XCTAssertEqual(firstCart.row, 4)
        XCTAssertEqual(firstCart.col, 8)
        
        day.step()
        XCTAssertEqual(firstCart.currentDirection, .up)
        XCTAssertEqual(firstCart.row, 4)
        XCTAssertEqual(firstCart.col, 7)
        
        let tick = day.step()
        XCTAssertEqual(firstCart.currentDirection, .up)
        XCTAssertEqual(firstCart.row, 3)
        XCTAssertEqual(firstCart.col, 7)
        XCTAssertEqual(lastCart.currentDirection, .down)
        XCTAssertEqual(lastCart.row, 3)
        XCTAssertEqual(lastCart.col, 7)
        
        XCTAssertEqual(tick.crash?.x, 7)
        XCTAssertEqual(tick.crash?.y, 3)
    }
    
//    func testPart2Example() {
//        let testInput = """
//        />-<\\
//        |   |
//        | /<+-\\
//        | | | v
//        \\>+</ |
//          |   ^
//          \\<->/
//        """
//        let day = Day13(input: testInput)
//
//        (0..<20).forEach { step in
//            day.step()
//            day.printGrid()
//        }
//    }
}
