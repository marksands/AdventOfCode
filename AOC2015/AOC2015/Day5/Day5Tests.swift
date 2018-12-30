import XCTest
import AOC2015

class AOC2015_Day5_Tests: XCTestCase {
    let day = Day5()
    
    func testPart1() {
        XCTAssertEqual("258", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("53", day.part2())
    }
}
