import XCTest
import AOC2018

class AOC2018_Day22_Tests: XCTestCase {
    let day = Day22()
    
    func testPart1() {
        XCTAssertEqual("6323", day.part1())
    }

    func testPart2() {
        XCTAssertEqual("982", day.part2())
    }
}
