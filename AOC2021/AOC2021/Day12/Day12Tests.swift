import XCTest
import AOC2021

class AOC2021_Day12_Tests: XCTestCase {
	let day = Day12()

	func testPart1() {
		XCTAssertEqual("5254", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("149385", day.part2())
	}
}
