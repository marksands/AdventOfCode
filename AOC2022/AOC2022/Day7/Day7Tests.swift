import XCTest
import AOC2022

class AOC2022_Day7_Tests: XCTestCase {
	let day = Day7()

	func testPart1() {
		XCTAssertEqual("1770595", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("2195372", day.part2())
	}
}
