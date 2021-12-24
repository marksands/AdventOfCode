import XCTest
import AOC2021
import AdventOfCode

class AOC2021_Day20_Tests: XCTestCase {
	let day = Day20()

	func testPart1() {
		XCTAssertEqual("5391", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("16383", day.part2())
	}
}
