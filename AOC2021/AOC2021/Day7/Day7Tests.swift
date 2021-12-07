import XCTest
import AOC2021

class AOC2021_Day7_Tests: XCTestCase {
	let day = Day7()

	func testPart1() {
		XCTAssertEqual("343441", day.part1())
	}

	// 842941 is not right
	// 98928141 is not right
	func testPart2() {
		XCTAssertEqual("98925151", day.part2())
	}
}
