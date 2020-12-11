import XCTest
import AOC2020

class AOC2020_Day11_Tests: XCTestCase {
	let day = Day11()

	func testPart1() {
		XCTAssertEqual("2310", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("2074", day.part2())
	}
}
