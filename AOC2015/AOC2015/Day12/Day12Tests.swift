import XCTest
import AOC2015

class AOC2015_Day12_Tests: XCTestCase {
    let day = Day12()
    
    func testPart1() {
        XCTAssertEqual("191164", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("87842", day.part2())
    }
}
