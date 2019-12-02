import XCTest
import AOC2019

class AOC2019_Day2_Tests: XCTestCase {
    let day = Day2()
    
    func testPart1() {
        XCTAssertEqual("5866663", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("4259", day.part2())
    }
}
