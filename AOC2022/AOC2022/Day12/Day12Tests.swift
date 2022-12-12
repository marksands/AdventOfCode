import XCTest
import AOC2022

class AOC2022_Day12_Tests: XCTestCase {
	let day = Day12()

	func testPart1() {
		XCTAssertEqual("412", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("402", day.part2())
	}
}
