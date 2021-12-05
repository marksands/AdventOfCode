import XCTest
import AOC2021

class AOC2021_Day5_Tests: XCTestCase {
	let day = Day5()

	func testPart1() {
		XCTAssertEqual("6572", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("21466", day.part2())
	}
}
