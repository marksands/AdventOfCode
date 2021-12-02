import XCTest
import AOC2021

class AOC2021_Day2_Tests: XCTestCase {
	let day = Day2()

    func testPart1() {
        XCTAssertEqual("1488669", day.part1())
    }

    func testPart2() {
        XCTAssertEqual("1176514794", day.part2())
    }
}
