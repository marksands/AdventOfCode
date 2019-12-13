import XCTest
import AOC2019

class Day13Tests: XCTestCase {
    func testOne() {
        let day = Day13()
        XCTAssertEqual("247", day.part1())
    }
    
    func testTwo() {
        let day = Day13()
        XCTAssertEqual("12954", day.part2())
    }
}
