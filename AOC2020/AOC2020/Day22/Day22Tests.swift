import XCTest
import AOC2020

class AOC2020_Day22_Tests: XCTestCase {
	let day = Day22()

	func testPart1() {
		XCTAssertEqual("33694", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("31835", day.part2())
	}
}
