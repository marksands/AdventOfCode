import XCTest
import AOC2022

class AOC2022_Day5_Tests: XCTestCase {
	let day = Day5()

	func testPart1() {
		XCTAssertEqual("PTWLTDSJV", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("WZMFVGGZP", day.part2())
	}
}
