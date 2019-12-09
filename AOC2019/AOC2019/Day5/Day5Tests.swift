import XCTest
import AOC2019

class Day5Tests: XCTestCase {
    func testOne() {
        let day = Day5()
        XCTAssertEqual("5577461", day.part1())
    }
    
    func testTwo() {
        let day = Day5()
        XCTAssertEqual("7161591", day.part2())
    }
}
