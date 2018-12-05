import XCTest
import AOC2018

class AOC2018_Day5_Tests: XCTestCase {
    let day = Day5()
    
    func testPart1() {
        XCTAssertEqual("10774", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("5122", day.part2())
    }
    
    func testRemovingOne() {
        XCTAssertEqual("", day.removingAdjacentOpposingPolarities(from: "Aa"))
    }

    func testRemovingTwo() {
        XCTAssertEqual("", day.removingAdjacentOpposingPolarities(from: "aABb"))
    }
    
    func testRemovingEnds() {
        XCTAssertEqual("Cd", day.removingAdjacentOpposingPolarities(from: "aACdBb"))
    }
    
    func testRemovingMiddleCanRemoveSquishedResult() {
        XCTAssertEqual("", day.removingAdjacentOpposingPolarities(from: "aCcA"))
    }

    func testRemovingMiddle() {
        XCTAssertEqual("aB", day.removingAdjacentOpposingPolarities(from: "aCcB"))
    }

    func testRemovingMiddleFurtherRemovesSquishedResults() {
        XCTAssertEqual("fg", day.removingAdjacentOpposingPolarities(from: "aEbDcCdBeAfg"))
    }
}
