import XCTest
import AOC2020

class AOC2020_Day13_Tests: XCTestCase {
	let day = Day13()

	func testPart1() {
		XCTAssertEqual("6568", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("554865447501099", day.part2())
	}
}
