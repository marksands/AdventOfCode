import XCTest
import AOC2021

class AOC2021_Day13_Tests: XCTestCase {
	let day = Day13()

	func testPart1() {
		XCTAssertEqual("664", day.part1())
	}

	func testPart2() {
		// EFJKZLBL
		XCTAssertEqual("91", day.part2())
	}
}
