import XCTest
import AOC2015

class AOC2015_Day2_Tests: XCTestCase {
    let day = Day2()
    
    func testPart1() {
        XCTAssertEqual("1588178", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("3783758", day.part2())
    }
}
