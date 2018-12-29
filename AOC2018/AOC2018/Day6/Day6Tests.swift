import XCTest
import AOC2018

class AOC2018_Day6_Tests: XCTestCase {
    let day = Day6()
    
    func testPart1() {
        XCTAssertEqual("4342", day.part1())
    }

    func testPart2() {
        XCTAssertEqual("42966", day.part2())
    }
}
