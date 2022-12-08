import XCTest
import AOC2022

class AOC2022_Day8_Tests: XCTestCase {
	let day = Day8()

	func testPart1() {
		XCTAssertEqual("1538", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("496125", day.part2())
	}
}
