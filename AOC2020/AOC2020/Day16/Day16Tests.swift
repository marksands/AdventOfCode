import XCTest
import AOC2020

class AOC2020_Day16_Tests: XCTestCase {
	let day = Day16()

	func testPart1() {
		XCTAssertEqual("30869", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("4381476149273", day.part2())
	}
}
