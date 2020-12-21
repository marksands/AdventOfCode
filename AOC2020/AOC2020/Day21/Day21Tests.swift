import XCTest
import AOC2020

class AOC2020_Day21_Tests: XCTestCase {
	let day = Day21()

	func testPart1() {
		XCTAssertEqual("2573", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("bjpkhx,nsnqf,snhph,zmfqpn,qrbnjtj,dbhfd,thn,sthnsg", day.part2())
	}
}
