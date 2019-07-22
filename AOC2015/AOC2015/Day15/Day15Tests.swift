import XCTest
import AOC2015

class AOC2015_Day15_Tests: XCTestCase {
    let sample = """
Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
"""
    
    func testSample() {
        let day = Day15(input: sample.components(separatedBy: .newlines))
        _ = day.part1()
    }
    
    func testPart1() {
        let day = Day15()
        XCTAssertEqual("21367368", day.part1())
    }
    
    func testPart2() {
        let day = Day15()
        XCTAssertEqual("1766400", day.part2())
    }
}
