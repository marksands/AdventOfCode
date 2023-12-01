import XCTest
import AOC2023

class AOC2023_Day1_Tests: XCTestCase {
    enum Fixture {
        static let input1 = """
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
"""
        static let input2 = """
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
"""
    }

    func testExamplePart1() {
        let day = Day1(rawInput: Fixture.input1)
        XCTAssertEqual("142", day.part1())
    }

    func testExamplePart2() {
        let day = Day1(rawInput: Fixture.input2)
        XCTAssertEqual("281", day.part2())
    }

	func testPart1() {
        let day = Day1()
		XCTAssertEqual("55029", day.part1())
	}

	func testPart2() {
        let day = Day1()
		XCTAssertEqual("55686", day.part2())
	}
}
