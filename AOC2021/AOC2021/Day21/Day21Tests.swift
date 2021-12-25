import XCTest
import AOC2021

class AOC2021_Day21_Tests: XCTestCase {
	let day = Day21()

	func testPart1() {
		XCTAssertEqual("798147", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("809953813657517", day.part2())
	}
}
