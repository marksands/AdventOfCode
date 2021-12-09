import XCTest
import AOC2021

class AOC2021_Day9_Tests: XCTestCase {
	let day = Day9()

	func testPart1() {
		XCTAssertEqual("480", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("1045660", day.part2())
	}
}
