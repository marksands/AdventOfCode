import XCTest
import AOC2021

class AOC2021_Day1_Tests: XCTestCase {
	let day = Day1()

	func testPart1() {
		XCTAssertEqual("1387", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("1362", day.part2())
	}
}
