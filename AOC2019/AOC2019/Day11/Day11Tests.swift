import XCTest
import AOC2019

class Day11Tests: XCTestCase {
    func testOne() {
        let day = Day11()
        XCTAssertEqual("1883", day.part1())
    }
    
    func testTwo() {
        let day = Day11()
        XCTAssertEqual("APUGURFH", day.part2())
    }
}
