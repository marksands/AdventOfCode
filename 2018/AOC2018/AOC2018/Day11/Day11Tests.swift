import XCTest
import AOC2018

class AOC2018_Day11_Tests: XCTestCase {
    let day = Day11()
    
    func testPart1() {
        XCTAssertEqual("21,22", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("235,288,13", day.part2())
    }
}
