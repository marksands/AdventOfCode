import XCTest
import AOC2015

class AOC2015_Day1_Tests: XCTestCase {
    let day = Day1()
    
    func testPart1() {
        XCTAssertEqual("138", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("1771", day.part2())
    }
}
