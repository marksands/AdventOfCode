import XCTest
import AOC2015

class AOC2015_Day13_Tests: XCTestCase {
    let sample = """
Alice would gain 54 happiness units by sitting next to Bob.
Alice would lose 79 happiness units by sitting next to Carol.
Alice would lose 2 happiness units by sitting next to David.
Bob would gain 83 happiness units by sitting next to Alice.
Bob would lose 7 happiness units by sitting next to Carol.
Bob would lose 63 happiness units by sitting next to David.
Carol would lose 62 happiness units by sitting next to Alice.
Carol would gain 60 happiness units by sitting next to Bob.
Carol would gain 55 happiness units by sitting next to David.
David would gain 46 happiness units by sitting next to Alice.
David would lose 7 happiness units by sitting next to Bob.
David would gain 41 happiness units by sitting next to Carol.
"""
    
    func testSample() {
        let day = Day13(input: sample.components(separatedBy: .newlines))
        XCTAssertEqual("330", day.part1())
    }

    func testPart1() {
        let day = Day13()
        XCTAssertEqual("709", day.part1())
    }
    
    func testPart2() {
        let day = Day13()
        XCTAssertEqual("668", day.part2())
    }
}
