import XCTest
import AOC2018

class AOC2018_Day17_Tests: XCTestCase {
    func testPart1() {
        let day = Day17()
        XCTAssertEqual("TBD", day.part1())
    }
    
    func testPart2() {
        let day = Day17()
        XCTAssertEqual("TBD", day.part2())
    }
    
    func testBoundingRectForDesertInput() {
        let input = """
        x=2, y=1..3
        x=5, y=1..3
        y=3, x=3..4
        x=5, y=5..6
        x=8, y=5..6
        y=6, x=6..7
        """
        
        let day = Day17(input: input)
        
        let expected = CGRect(x: 0, y: 0, width: 8, height: 6)
        XCTAssertEqual(expected, day.boundingRect())
    }
    
    func testPrintsDesert() {
        let input = """
        x=2, y=1..3
        x=5, y=1..3
        y=3, x=3..4
        x=5, y=5..6
        x=8, y=5..6
        y=6, x=6..7
        """
        
        let day = Day17(input: input)
        
        let expected = """
            .........
            ..#..#...
            ..#..#...
            ..####...
            .........
            .....#..#
            .....####\n
            """
        XCTAssertEqual(expected, day.printableDesert())
    }
    
    // test: verify that minX is 0, render desert to maxX or some padding
    // test: verify minY is 0 even though tiles are not counted less than the minY from the input
}
