import XCTest
import AOC2019

class Day10Tests: XCTestCase {
    func testOne() {
        let day = Day10()
        XCTAssertEqual("276", day.part1())
    }
    
    func testTwo() {
        let day = Day10()
        XCTAssertEqual("1321", day.part2())
    }
}
