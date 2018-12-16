import XCTest
import AOC2018

class AOC2018_Day15_Tests: XCTestCase {
    var testInput = """
            #######
            #.G...#
            #...EG#
            #.#.#G#
            #..G#E#
            #.....#
            #######
            """
    
    func testPart1() {
        let day = Day15(input: testInput)
        print(day.printableMap())
        XCTAssertEqual("TBD", day.part1())
    }
    
    func testPart2() {
        let day = Day15(input: testInput)
        print(day.printableMap())
        XCTAssertEqual("TBD", day.part2())
    }
    
    func testMapRendersOnlyTerritory() {
        let expected = """
            #######
            #.....#
            #.....#
            #.#.#.#
            #...#.#
            #.....#
            #######\n
            """
        
        let day = Day15(input: testInput)
        XCTAssertEqual(expected, day.printableMap())
    }
    
    func testNeighborsOfIsolatedUnit() {
        let day = Day15(input: testInput)
        let neighbors = day.neighbors(for: Position(x: 2, y: 1))
        
        let expected = [Position(x: 1, y: 1), Position(x: 3, y: 1), Position(x: 2, y: 2)]
        XCTAssertEqual(expected, neighbors)
    }
    
    func testNeighborsOfOpenTerritory() {
        let day = Day15(input: testInput)
        let neighbors = day.neighbors(for: Position(x: 3, y: 3))
        
        let expected = [Position(x: 3, y: 2), Position(x: 3, y: 4)]
        XCTAssertEqual(expected, neighbors)
    }
    
    func testNeighborsOfUnitSurroundedByOtherUnits() {
        let day = Day15(input: testInput)
        let neighbors = day.neighbors(for: Position(x: 5, y: 2))
        
        let expected = [Position(x: 5, y: 1), Position(x: 4, y: 2), Position(x: 5, y: 3)]
        XCTAssertEqual(expected, neighbors)
    }

    func testPathFromGoblinToElf() {
        let day = Day15(input: testInput)
        let goblin = day.units.first(where: { $0.position == Position(x: 2, y: 1) })!
        let elf = day.units.first(where: { $0.position == Position(x: 4, y: 2) })!
        
        let path = day.path(from: goblin, to: elf)

        let expected = [Position(x: 3, y: 1), Position(x: 4, y: 1)]
        XCTAssertEqual(expected, path)
    }
//    var testInput = """
//            #######
//            #.G@@.#
//            #...EG#
//            #.#.#G#
//            #..G#E#
//            #.....#
//            #######
//            """
    
    func testPathFromGoblinToElf2() {
        let day = Day15(input: testInput)
        let goblin = day.units.first(where: { $0.position == Position(x: 3, y: 4) })!
        let elf = day.units.first(where: { $0.position == Position(x: 4, y: 2) })!
        
        let path = day.path(from: goblin, to: elf)
        
        let expected = [Position(x: 3, y: 3), Position(x: 3, y: 2)]
        XCTAssertEqual(expected, path)
    }
}
