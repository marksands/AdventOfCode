import XCTest
import AOC2015

class AOC2015_Day14_Tests: XCTestCase {
    let day = Day14()
    
    func testPart1() {
        XCTAssertEqual("2640", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("1102", day.part2())
    }
    
    func testSimpleDeerState() {
        let input = """
        A can fly 10 km/s for 10 seconds, but then must rest for 10 seconds.
        B can fly 10 km/s for 5 seconds, but then must rest for 10 seconds.
        """
        
        let testObject = Day14(seconds: 61, input: input.components(separatedBy: .newlines))
        XCTAssertEqual("310", testObject.part1())
        XCTAssertEqual("61", testObject.part2())
    }
}
