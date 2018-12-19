import XCTest
import AOC2018

class AOC2018_Day17_Tests: XCTestCase {
//    func testPart1() {
//        let day = Day17()
//        print(day.printableDesert())
//        XCTAssertEqual("TBD", day.part1())
//    }
//
//    func testPart2() {
//        let day = Day17()
//        XCTAssertEqual("TBD", day.part2())
//    }
    
    func testBoundingRectForDesertInput() {
        let input = """
        x=2, y=2..4
        x=5, y=2..4
        y=4, x=3..4
        x=5, y=6..7
        x=8, y=6..7
        y=7, x=6..7
        """
        
        let day = Day17(input: input)
        
        let expected = CGRect(x: 0, y: 0, width: 8, height: 7)
        XCTAssertEqual(expected, day.boundingRect())
    }
    
    func testPrintsDesert() {
        let input = """
        x=2, y=2..4
        x=5, y=2..4
        y=4, x=3..4
        x=5, y=6..7
        x=8, y=5..7
        y=7, x=6..7
        """
        
        let day = Day17(input: input, springXPosition: 4)
        
        let expected = """
            ....+....
            .........
            ..#..#...
            ..#..#...
            ..####...
            ........#
            .....#..#
            .....####\n
            """
        XCTAssertEqual(expected, day.printableDesert())
    }
    
    func testFloodFillSimplest() {
        let input = """
            x=8, y=5..7
            """
        
        let day = Day17(input: input, springXPosition: 4)
        day.floodFill()
        
        let expected = """
            ....+....
            ....|....
            ....|....
            ....|....
            ....|....
            ....|...#
            ....|...#
            ....|...#\n
            """
        XCTAssertEqual(expected, day.printableDesert())
    }
    
    func testFloodFillsBowl() {
        let input = """
            x=2, y=3..6
            y=6, x=3..4
            x=4, y=4..5
            x=8, y=6..7
            """
        
        let day = Day17(input: input, springXPosition: 4)
        day.floodFill()
        
        let expected = """
            ....+....
            ....|....
            ....|....
            ..#|||...
            ..#~#|...
            ..#~#|...
            ..###|..#
            .....|..#\n
            """
        XCTAssertEqual(expected, day.printableDesert())
    }
    
    func testFloodFillSimpleBowl() {
        let input = """
            x=2, y=3..4
            x=6, y=3..4
            y=4, x=3..5
            x=8, y=4..6
            """

        let day = Day17(input: input, springXPosition: 4)
        day.floodFill()

        let expected = """
            ....+....
            ....|....
            .|||||||.
            .|#~~~#|.
            .|#####|#
            .|.....|#
            .|.....|#\n
            """
        XCTAssertEqual(expected, day.printableDesert())
    }

//    let expected = """
//            ....+....
//            .#||||||.
//            .#~~~~#|.
//            .#~##~#|.
//            .#~~~~#|.
//            .######|.
//            .......|.
//            .......|#\n
//            """

    //    let expected = """
    //            ....+....
    //            #|||||||.
    //            #~#~#~#|.
    //            #~###~#|.
    //            #~~~~~#|.
    //            #######|.
    //            .......|.
    //            .......|#\n
    //            """


//    func testFloodFillSimpleDesert() {
//        let input = """
//            x=2, y=2..4
//            x=5, y=2..4
//            y=4, x=3..4
//            x=5, y=6..7
//            x=8, y=5..7
//            y=7, x=6..7
//            """
//
//        let day = Day17(input: input, springXPosition: 4)
//        day.floodFill()
//
//        let expected = """
//            ....+....
//            .||||||..
//            .|#~~#|..
//            .|#~~#|..
//            .|####|..
//            .|..||||#
//            .|..|#~~#
//            .|..|####\n
//            """
//        XCTAssertEqual(expected, day.printableDesert())
//    }
    
    //func test
    
    // test: verify that minX is 0, render desert to maxX or some padding
    // test: verify minY is 0 even though tiles are not counted less than the minY from the input
}
