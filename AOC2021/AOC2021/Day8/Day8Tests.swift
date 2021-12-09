import XCTest
import AOC2021

class AOC2021_Day8_Tests: XCTestCase {
	let day = Day8()

	func testPart1() {
		XCTAssertEqual("470", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("989396", day.part2())
	}
}
