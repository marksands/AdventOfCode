import XCTest
import AOC2020

class AOC2020_Day24_Tests: XCTestCase {
	let day = Day24()

	func testPart1() {
		XCTAssertEqual("312", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("3733", day.part2())
	}
}
