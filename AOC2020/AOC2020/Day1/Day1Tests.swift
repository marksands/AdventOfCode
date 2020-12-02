import XCTest
import AOC2020

class AOC2020_Day1_Tests: XCTestCase {
	let day = Day1()

	func testPart1() {
		XCTAssertEqual("926464", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("65656536", day.part2())
	}
}
