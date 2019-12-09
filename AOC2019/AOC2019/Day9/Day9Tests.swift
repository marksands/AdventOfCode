import XCTest
import AOC2019

class Day9Tests: XCTestCase {
    func testOne() {
        let day = Day9()
        XCTAssertEqual("2932210790", day.part1())
    }
    
    func testTwo() {
        let day = Day9()
        XCTAssertEqual("73144", day.part2())
    }
}
