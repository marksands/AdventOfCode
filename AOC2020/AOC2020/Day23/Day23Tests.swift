import XCTest
import AOC2020

class AOC2020_Day23_Tests: XCTestCase {
	let day = Day23()

	func testPart1() {
		XCTAssertEqual("97632548", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("412990492266", day.part2())
	}
}
