import XCTest
import AOC2018

class AOC2018_Day2_Tests: XCTestCase {
    let day = Day2()
    
    func testPart1() {
        XCTAssertEqual("5681", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("uqyoeizfvmbistpkgnocjtwld", day.part2())
    }
}
