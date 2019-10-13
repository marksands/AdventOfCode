import XCTest
import AOC2015

class Day20Tests: XCTestCase {
    func testPart1() {
        let day = Day20()
        XCTAssertEqual("831600", day.part1())
    }
    
    func testPart2() {
        let day = Day20()
        XCTAssertEqual("884520", day.part2())
    }
}
