import XCTest
import AOC2015

class AOC2015_Day6_Tests: XCTestCase {
    let day = Day6()
    
    func testPart1() {
        XCTAssertEqual("543903", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("14687245", day.part2())
    }
}
