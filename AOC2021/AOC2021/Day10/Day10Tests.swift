import XCTest
import AOC2021

class AOC2021_Day10_Tests: XCTestCase {
	let day = Day10()

	func testPart1() {
		XCTAssertEqual("415953", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("2292863731", day.part2())
	}
}
