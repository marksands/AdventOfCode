import XCTest
import AOC2018

class AOC2018_Day21_Tests: XCTestCase {
    let day = Day21()
    
    func testPart1() {
        XCTAssertEqual("13522479", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("14626276", day.part2())
    }
    
    func testDisassembly() {
        day.disassemble()
    }
}
