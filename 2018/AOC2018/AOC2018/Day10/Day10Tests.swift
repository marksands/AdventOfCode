import XCTest
import AOC2018

class AOC2018_Day10_Tests: XCTestCase {
    let day = Day10()
    
    func testPart1() {
        XCTAssertEqual("RLEZNRAN", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("10240", day.part2())
    }
}
