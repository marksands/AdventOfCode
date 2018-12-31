import XCTest
import AOC2015

class AOC2015_Day8_Tests: XCTestCase {
    let day = Day8()
    
    func testPart1() {
        XCTAssertEqual("1350", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("2085", day.part2())
    }
}
