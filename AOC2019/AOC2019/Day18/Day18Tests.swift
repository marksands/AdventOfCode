import XCTest
import AOC2019

class Day18Tests: XCTestCase {
	func testOne() {
		let day = Day18()
		// Tried 113 is too low.
		// Tried 5767 is too high.
		// Tried 5635 is too high.
		XCTAssertEqual("", day.part1())
	}

	func testTwo() {
		let day = Day18()
		XCTAssertEqual("", day.part2())
	}
}
