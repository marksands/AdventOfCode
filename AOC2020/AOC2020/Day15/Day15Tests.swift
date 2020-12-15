import XCTest
import AOC2020

class AOC2020_Day15_Tests: XCTestCase {
	let day = Day15()

	func testPart1() {
		XCTAssertEqual("1280", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("651639", day.part2())
	}
}
