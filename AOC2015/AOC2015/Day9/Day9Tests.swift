import XCTest
import AOC2015

class AOC2015_Day9_Tests: XCTestCase {
    let day = Day9()
    
    func testPart1() {
        XCTAssertEqual("117", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("909", day.part2())
    }
}
