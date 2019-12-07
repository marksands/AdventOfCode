import XCTest
import AOC2019

class Day7Tests: XCTestCase {
    func testOne() {
        let day = Day7()
        XCTAssertEqual("65464", day.part1())
    }
    
    func testTwo() {
        let day = Day7()
        XCTAssertEqual("1518124", day.part2())
    }
    
}
