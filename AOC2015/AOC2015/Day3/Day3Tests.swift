import XCTest
import AOC2015

class AOC2015_Day3_Tests: XCTestCase {
    let day = Day3()
    
    func testPart1() {
        XCTAssertEqual("2565", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("2639", day.part2())
    }
}
