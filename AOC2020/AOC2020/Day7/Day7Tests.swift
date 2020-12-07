import XCTest
import AOC2020

class AOC2020_Day7_Tests: XCTestCase {
	let day = Day7()

	func testPart1() {
		XCTAssertEqual("169", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("82372", day.part2())
	}
}
