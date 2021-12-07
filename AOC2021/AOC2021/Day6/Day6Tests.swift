import XCTest
import AOC2021

class AOC2021_Day6_Tests: XCTestCase {
	let day = Day6()

	func testPart1() {
		XCTAssertEqual("380758", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("1710623015163", day.part2())
	}
}
