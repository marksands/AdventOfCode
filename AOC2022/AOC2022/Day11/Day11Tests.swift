import XCTest
import AOC2022

class AOC2022_Day11_Tests: XCTestCase {
	let day = Day11()

	func testPart1() {
		XCTAssertEqual("111210", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("15447387620", day.part2())
	}
}
