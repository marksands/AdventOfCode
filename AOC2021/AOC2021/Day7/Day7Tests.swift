import XCTest
import AOC2021

class AOC2021_Day7_Tests: XCTestCase {
	let day = Day7()

	func testPart1() {
		XCTAssertEqual("343441", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("98925151", day.part2())
	}
}
