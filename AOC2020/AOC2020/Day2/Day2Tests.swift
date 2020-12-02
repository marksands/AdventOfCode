import XCTest
import AOC2020

class AOC2020_Day2_Tests: XCTestCase {
	let day = Day2()

	func testPart1() {
		XCTAssertEqual("660", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("530", day.part2())
	}
}
