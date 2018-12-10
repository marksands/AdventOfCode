import XCTest
import AOC2018

class AOC2018_Day7_Tests: XCTestCase {
    let day = Day7()
    
    func testPart1() {
        XCTAssertEqual("JKNSTHCBGRVDXWAYFOQLMPZIUE", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("755", day.part2())
    }
}
