import XCTest
import AOC2020

class AOC2020_Day8_Tests: XCTestCase {
	let day = Day8()

	func testPart1() {
		XCTAssertEqual("1331", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("1121", day.part2())
	}
}
