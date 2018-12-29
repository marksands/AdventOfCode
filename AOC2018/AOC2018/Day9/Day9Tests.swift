import XCTest
import AOC2018

class AOC2018_Day9_Tests: XCTestCase {
    let day = Day9()
    
    func testPart1() {
        XCTAssertEqual("416424", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("3498287922", day.part2())
    }
}
