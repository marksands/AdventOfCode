import XCTest
import AOC2018

class AOC2018_Day1_Tests: XCTestCase {
    let day = Day1()

    func testPart1() {
        XCTAssertEqual("574", day.part1())
    }

    func testPart2() {
        XCTAssertEqual("452", day.part2())
    }
}
