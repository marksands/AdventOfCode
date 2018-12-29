import XCTest
import AOC2015

class AOC2015_Day4_Tests: XCTestCase {
    let day = Day4()
    
    func testPart1() {
        XCTAssertEqual("117946", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("3938038", day.part2())
    }
}
