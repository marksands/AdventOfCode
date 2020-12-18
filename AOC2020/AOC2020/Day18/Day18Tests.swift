import XCTest
import AOC2020

class AOC2020_Day18_Tests: XCTestCase {
	let day = Day18()

	func testPart1() {
		XCTAssertEqual("3647606140187", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("323802071857594", day.part2())
	}
}
