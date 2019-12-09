import XCTest
import AOC2019

class Day6Tests: XCTestCase {
    func testOne() {
        let day = Day6()
        XCTAssertEqual("122782", day.part1())
    }
    
    func testTwo() {
        let day = Day6()
        XCTAssertEqual("271", day.part2())
    }

}
