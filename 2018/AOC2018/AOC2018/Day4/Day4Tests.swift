import XCTest
import AOC2018

class AOC2018_Day4_Tests: XCTestCase {
    let day = Day4()
    
    func testPart1() {
        XCTAssertEqual("87681", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("136461", day.part2())
    }
}
