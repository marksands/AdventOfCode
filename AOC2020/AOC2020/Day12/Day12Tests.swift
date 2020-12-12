import XCTest
import AOC2020

class AOC2020_Day12_Tests: XCTestCase {
	let day = Day12()

	func testPart1() {
		XCTAssertEqual("923", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("24769", day.part2())
	}
}
