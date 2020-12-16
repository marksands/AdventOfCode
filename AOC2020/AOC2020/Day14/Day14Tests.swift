import XCTest
import AOC2020

class AOC2020_Day14_Tests: XCTestCase {
	let day = Day14()

	func testPart1() {
		XCTAssertEqual("14954914379452", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("3415488160714", day.part2())
	}
}
