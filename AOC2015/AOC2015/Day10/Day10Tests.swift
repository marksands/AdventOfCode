import XCTest
import AOC2015

class AOC2015_Day10_Tests: XCTestCase {
    let day = Day10()
    
    func testPart1() {
        XCTAssertEqual("492982", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("6989950", day.part2())
    }
}
