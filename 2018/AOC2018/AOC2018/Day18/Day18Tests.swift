import XCTest
import AOC2018

class AOC2018_Day18_Tests: XCTestCase {
    let day = Day18()
    
    func testPart1() {
        XCTAssertEqual("621205", day.part1())
    }
    
    func testPart2() {
        XCTAssertEqual("TBD", day.part2())
    }
    
    func testPrintableBoard() {
        let input = """
        .#.#...|#.
        .....#|##|
        .|..|...#.
        ..|#.....#
        #.#|||#|#|
        ...#.||...
        .|....|...
        ||...#|.#|
        |.||||..|.
        ...#.|..|.\n
        """
        
        let day = Day18(input: input)
        XCTAssertEqual(input, day.printableBoard())
    }
    
    func testMutateAfterOneMinute() {
        let input = """
        .#.#...|#.
        .....#|##|
        .|..|...#.
        ..|#.....#
        #.#|||#|#|
        ...#.||...
        .|....|...
        ||...#|.#|
        |.||||..|.
        ...#.|..|.\n
        """
        
        let expected = """
        .......##.
        ......|###
        .|..|...#.
        ..|#||...#
        ..##||.|#|
        ...#||||..
        ||...|||..
        |||||.||.|
        ||||||||||
        ....||..|.\n
        """
        
        let day = Day18(input: input)
        day.mutate()
        XCTAssertEqual(expected, day.printableBoard())
    }
    
    func testMutateAfter10Minutes() {
        let input = """
        .#.#...|#.
        .....#|##|
        .|..|...#.
        ..|#.....#
        #.#|||#|#|
        ...#.||...
        .|....|...
        ||...#|.#|
        |.||||..|.
        ...#.|..|.\n
        """
        
        let expected = """
        .||##.....
        ||###.....
        ||##......
        |##.....##
        |##.....##
        |##....##|
        ||##.####|
        ||#####|||
        ||||#|||||
        ||||||||||\n
        """
        
        let day = Day18(input: input)
        (1...10).forEach { _ in day.mutate() }
        XCTAssertEqual(expected, day.printableBoard())
    }
}
