import XCTest
import AOC2021

class AOC2021_Day14_Tests: XCTestCase {
	let day = Day14()

	func testPart1() {
		XCTAssertEqual("3118", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("4332887448171", day.part2())
	}
}
