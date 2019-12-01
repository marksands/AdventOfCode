import XCTest
import AOC2019

class AOC2019_Day1_Tests: XCTestCase {
    let day = Day1()
    
    func testPart1() {
        XCTAssertEqual("3386686", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("5077155", day.part2())
    }
}
