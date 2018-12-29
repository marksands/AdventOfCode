import XCTest
import AOC2018

class AOC2018_Day23_Tests: XCTestCase {
    let day = Day23()
    
    func testPart1() {
        XCTAssertEqual("674", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("129444177", day.part2())
    }
}
