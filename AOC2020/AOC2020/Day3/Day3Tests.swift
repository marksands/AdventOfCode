import XCTest
import AOC2020

class AOC2020_Day3_Tests: XCTestCase {
	let day = Day3()

	func testPart1() {
		XCTAssertEqual("200", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("3737923200", day.part2())
	}
}
