import XCTest
import AdventOfCode
import AOC2021

class AOC2021_Day19_Tests: XCTestCase {
	let day = Day19()

	func testPart1() { // 255 is too low
		XCTAssertEqual("", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("", day.part2())
	}

	func testTranslation() {
		let p1 = Position(x: 0, y: 0)
		let p2 = Position(x: 5, y: 0)
		XCTAssertEqual(p1.translation(to: p2), Position(x: 5, y: 0))
		XCTAssertEqual(p2 - p1.translation(to: p2), p1)
		XCTAssertEqual(p2.translation(to: p1), Position(x: -5, y: 0))

		let p3 = Position(x: 0, y: 7)
		let p4 = Position(x: -1, y: 0)
		XCTAssertEqual(p3.translation(to: p4), Position(x: -1, y: -7))
		XCTAssertEqual(p4 - p3.translation(to: p4), p3)
		XCTAssertEqual(p4.translation(to: p3), Position(x: 1, y: 7))
	}

	func testScannerTranslation1() {
		let scanner = Day19.Scanner(id: 0, positions: [
			Position(x: 0, y: 0),
			Position(x: 5, y: 0),
			Position(x: -3, y: 3, z: 2)
		])

		let actualScanner = scanner.scannerByTranslatingPositions(by: Position(x: 1, y: 1, z: 3))
		XCTAssertEqual(actualScanner, Day19.Scanner(id: 0, positions: [
			Position(x: 1, y: 1, z: 3),
			Position(x: 6, y: 1, z: 3),
			Position(x: -2, y: 4, z: 5)
		]))
	}
	
	func testScannerTranslation2() {
		let scanner = Day19.Scanner(id: 0, positions: [
			Position(x: 0, y: 0),
			Position(x: 5, y: 0),
			Position(x: -3, y: 3, z: 2)
		])

		let actualScanner = scanner.scannerByTranslatingPositions(by: Position(x: -1, y: 1, z: -3))
		XCTAssertEqual(actualScanner, Day19.Scanner(id: 0, positions: [
			Position(x: -1, y: 1, z: -3),
			Position(x: 4, y: 1, z: -3),
			Position(x: -4, y: 4, z: -1)
		]))
	}
	
	func testAllPossibleScanners1() {
		let origin = Day19.Scanner(id: 1, positions: [Position(x: 1, y: 1, z: -1)])
		let actualSacnners = origin.allPossibleScanners()

		XCTAssertEqual(actualSacnners.count, 24)
		XCTAssertEqual(actualSacnners.first!.positions, origin.positions)
		
	}

	func testCommonBeaconCount() {
		let scanner0 = Day19.Scanner(id: 0, positions: [
			Position(x: 0, y: 2),
			Position(x: 4, y: 1),
			Position(x: 3, y: 3)
		])
		
		let scanner1 = Day19.Scanner(id: 1, positions: [
			Position(x: -1, y: -1),
			Position(x: -5, y: 0),
			Position(x: -2, y: 1)
		])
		
		XCTAssertEqual(day.commonBeaconCount(scanner0, scanner1).0, 3)
		XCTAssertEqual(day.commonBeaconCount(scanner0, scanner1).1, [
				Position(x: 4, y: 1),
				Position(x: 0, y: 2),
				Position(x: 3, y: 3)
			]
		)
//		XCTAssertEqual(day.commonBeaconCount(scanner0, scanner1).1, Day19.Scanner(
//			id: 1, origin: Position(x: 5, y: 2), positions: [
//				Position(x: -1, y: -1),
//				Position(x: -5, y: 0),
//				Position(x: -2, y: 1)
//			]
//		))
	}
}

// I can find every beacon except those that lie outside of the boundaries:
//
// 1135,-1161,1235
// 1243,-1093,1063
// 1660,-552,429
// 1693,-557,386
// 1735,-437,1738
// 1749,-1800,1813
// 1772,-405,1572
// 1776,-675,371
// 1779,-442,1789
// 1780,-1548,337
// 1786,-1538,337
// 1847,-1591,415
// 1889,-1729,1762
// 1994,-1805,1792
