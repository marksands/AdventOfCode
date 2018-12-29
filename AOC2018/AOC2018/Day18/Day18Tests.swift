import XCTest
import AOC2018

class AOC2018_Day18_Tests: XCTestCase {
    let day = Day18()
    
    func testPart1() {
        XCTAssertEqual("621205", day.part1())
    }

    func testPart2() {
        XCTAssertEqual("228490", day.part2())
    }
}
