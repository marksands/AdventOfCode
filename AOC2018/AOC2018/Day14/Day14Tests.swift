import XCTest
import AOC2018

class AOC2018_Day14_Tests: XCTestCase {
    let day = Day14()
    
    func testPart1() {
        XCTAssertEqual("3171123923", day.part1())
    }

    func testPart2() {
        XCTAssertEqual("20353748", day.part2())
    }
}
