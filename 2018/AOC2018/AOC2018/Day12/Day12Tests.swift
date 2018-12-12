import XCTest
import AOC2018

class AOC2018_Day12_Tests: XCTestCase {
    let day = Day12()
    
    func testPart1() {
        XCTAssertEqual("1991", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("1100000000511", day.part2())
    }
}
