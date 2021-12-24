import XCTest
import AdventOfCode
import AOC2021

class AOC2021_Day19_Tests: XCTestCase {
	let day = Day19()

	func testPart1() {
		XCTAssertEqual("335", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("10864", day.part2())
	}
}
