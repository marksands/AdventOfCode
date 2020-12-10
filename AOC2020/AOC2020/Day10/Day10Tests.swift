import XCTest
import AOC2020

class AOC2020_Day10_Tests: XCTestCase {
	let day = Day10()

	func testPart1() {
		XCTAssertEqual("2343", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("31581162962944", day.part2())
	}
}
