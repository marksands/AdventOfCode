import XCTest
import AOC2018

class AOC2018_Day8_Tests: XCTestCase {
    let day = Day8()
    
    func testPart1() {
        XCTAssertEqual("42472", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("21810", day.part2())
    }
}
