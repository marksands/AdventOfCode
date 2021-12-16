import XCTest
import AOC2021

class AOC2021_Day16_Tests: XCTestCase {
	let day = Day16()

	func testPart1() {
		XCTAssertEqual("913", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("1510977819698", day.part2())
	}
	
	func testExamples() {
		let d1 = Day16(input: "C200B40A82")
		XCTAssertEqual(d1.part2(), "3")

		let d2 = Day16(input: "04005AC33890")
		XCTAssertEqual(d2.part2(), "54")

		let d3 = Day16(input: "880086C3E88112")
		XCTAssertEqual(d3.part2(), "7")

		let d4 = Day16(input: "CE00C43D881120")
		XCTAssertEqual(d4.part2(), "9")

		let d5 = Day16(input: "D8005AC2A8F0")
		XCTAssertEqual(d5.part2(), "1")

		let d6 = Day16(input: "F600BC2D8F")
		XCTAssertEqual(d6.part2(), "0")

		let d7 = Day16(input: "9C005AC2F8F0")
		XCTAssertEqual(d7.part2(), "0")

		let d8 = Day16(input: "9C0141080250320F1802104A08")
		XCTAssertEqual(d8.part2(), "1")
	}
}
