import XCTest
import AOC2018

class AOC2018_Day15_Tests: XCTestCase {
    let testInput = """
            #######
            #.G...#
            #...EG#
            #.#.#G#
            #..G#E#
            #.....#
            #######
            """
    
    func testPart1() {
        //let day = Day15()
        // 226620 is too low
        //XCTAssertEqual("226620", day.part1())
    }
    
    func testPart2() {
        let day = Day15(input: testInput)
        XCTAssertEqual("TBD", day.part2())
    }
    
    func testPrintableMapRendersOnlyTerritory() {
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
    
    func testPrintableRoundRendersTerritoryAndUnits() {
        let input = """
            ########
            #..G..##
            #.E##.##
            #...E.G#
            ########\n
            """
        let day = Day15(input: input)
        
        let expected = """
            ########
            #..G..##   G(200)
            #.E##.##   E(200)
            #...E.G#   E(200), G(200)
            ########\n
            """
        XCTAssertEqual(expected, day.printableRound())
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

        let expected = [Position(x: 3, y: 1), Position(x: 4, y: 1), Position(x: 4, y: 2)]
        XCTAssertEqual(expected, path)
    }
    
    func testPathFromGoblinToElf2() {
        let day = Day15(input: testInput)
        let goblin = day.units.first(where: { $0.position == Position(x: 3, y: 4) })!
        let elf = day.units.first(where: { $0.position == Position(x: 4, y: 2) })!
        
        let path = day.path(from: goblin, to: elf)
        
        let expected = [Position(x: 3, y: 3), Position(x: 3, y: 2), Position(x: 4, y: 2)]
        XCTAssertEqual(expected, path)
    }

    func testPathFromGoblinToElfGoesAroundFriendlies() {
        let input = """
            #######
            #.@@@@#
            #.G.GE#
            #.....#
            #######
            """
        let day = Day15(input: input)
        let goblin = day.units.first(where: { $0.position == Position(x: 2, y: 2) })!
        let elf = day.units.first(where: { $0.position == Position(x: 5, y: 2) })!
        
        let path = day.path(from: goblin, to: elf)
        
        let expected = [Position(x: 2, y: 1), Position(x: 3, y: 1), Position(x: 4, y: 1), Position(x: 5, y: 1), Position(x: 5, y: 2)]
        XCTAssertEqual(expected, path)
    }

    func testPathFromGoblinToElfGoesAroundFriendlies2() {
        let input = """
            #########
            #.......#
            #.G@@...#
            #...@.G.#
            #...@#..#
            #...@@E.#
            #########
            """
        let day = Day15(input: input)
        let goblin = day.units.first(where: { $0.position == Position(x: 2, y: 2) })!
        let elf = day.units.first(where: { $0.position == Position(x: 6, y: 5) })!
        
        let path = day.path(from: goblin, to: elf)
        
        let expected = [Position(x: 3, y: 2), Position(x: 4, y: 2), Position(x: 4, y: 3), Position(x: 4, y: 4),
                        Position(x: 4, y: 5), Position(x: 5, y: 5), Position(x: 6, y: 5)]
        XCTAssertEqual(expected, path)
    }
    
    func testPathFromGoblinWithinRangeOfElf() {
        let input = """
            ######
            #GE..#
            ######
            """
        let day = Day15(input: input)
        let goblin = day.units.first(where: { $0.position == Position(x: 1, y: 1) })!
        let elf = day.units.first(where: { $0.position == Position(x: 2, y: 1) })!
        
        let path = day.path(from: goblin, to: elf)
        
        let expected = [Position(x: 2, y: 1)]
        XCTAssertEqual(expected, path)
    }

    func testShortestPathFromGoblinToTarget() {
        let input = """
            #########
            #G@@@@@@#
            ###...#@#
            #E.G..GE#
            #########
            """
        let day = Day15(input: input)
        let goblin = day.units.first(where: { $0.position == Position(x: 1, y: 1) })!
        
        let path = day.shortestPathToEnemy(from: goblin)
        
        let expected = [Position(x: 2, y: 1), Position(x: 3, y: 1), Position(x: 4, y: 1),
                        Position(x: 5, y: 1), Position(x: 6, y: 1), Position(x: 7, y: 1),
                        Position(x: 7, y: 2), Position(x: 7, y: 3)]
        XCTAssertEqual(expected, path)
    }
    
    func testShortestPathHasZeroValidPaths() {
        let input = """
            #########
            #G......#
            ####...G#
            #E..G.GE#
            #########
            """
        let day = Day15(input: input)
        let goblin = day.units.first(where: { $0.position == Position(x: 1, y: 1) })!
        
        let path = day.shortestPathToEnemy(from: goblin)
        
        XCTAssertEqual([], path)
    }
    
    func testShortestPathBreaksAllTies() {
        let input = """
            #########
            #.E@@.E.#
            #E..G..E#
            #.E...E.#
            #########
            """
        let day = Day15(input: input)
        let goblin = day.units.first(where: { $0.position == Position(x: 4, y: 2) })!
        
        let path = day.shortestPathToEnemy(from: goblin)
        
        XCTAssertEqual([Position(x: 4, y: 1), Position(x: 3, y: 1), Position(x: 2, y: 1)], path)
    }
    
    func testEnemiesWithinRange() {
        let input = """
            ######
            #G...#
            #GE.G#
            #EE..#
            ######
            """
        let day = Day15(input: input)
        let goblin = day.units.first(where: { $0.position == Position(x: 1, y: 2) })!
        
        let enemy = day.enemyWithinRange(of: goblin)
        XCTAssertEqual(Position(x: 2, y: 2), enemy?.position)
    }

    func testEnemiesWithinRangeTiesByLowestHP() {
        let input = """
            ######
            #.G..#
            #GEG.#
            #.G..#
            ######
            """
        let day = Day15(input: input)
        
        sortedUnits(day.units, byRace: .goblin).last?.hp = 140
        let elf = sortedUnits(day.units, byRace: .elf).first!
        
        let enemy = day.enemyWithinRange(of: elf)!
        XCTAssertEqual(Position(x: 2, y: 3), enemy.position)
    }

    func testEnemiesWithinRangeTiesByLowestHPAndReadingOrder() {
        let input = """
            ######
            #.G..#
            #GEG.#
            #.G..#
            ######
            """
        let day = Day15(input: input)
        
        let goblins = sortedUnits(day.units, byRace: .goblin)
        goblins[1].hp = 130
        goblins[2].hp = 130
        
        let elf = sortedUnits(day.units, byRace: .elf).first!
        
        let enemy = day.enemyWithinRange(of: elf)!
        XCTAssertEqual(Position(x: 1, y: 2), enemy.position)
    }
    
    func test3RoundsFromExample1() {
        let input = """
            #########
            #G..G..G#
            #.......#
            #.......#
            #G..E..G#
            #.......#
            #.......#
            #G..G..G#
            #########
            """
        let day = Day15(input: input)
        
        day.battle()
        day.battle()
        day.battle()

        let expected = """
            #########
            #.......#
            #..GGG..#   G(200), G(191), G(200)
            #..GEG..#   G(200), E(185), G(200)
            #G..G...#   G(200), G(200)
            #......G#   G(200)
            #.......#
            #.......#
            #########\n
            """
        XCTAssertEqual(expected, day.printableRound())
    }

    func testExampleCombatFromExample1() {
        let input = """
            #######
            #.G...#
            #...EG#
            #.#.#G#
            #..G#E#
            #.....#
            #######
            """
        
        let day = Day15(input: input)
        
        (1...47).forEach { _ in
            day.battle()
        }
        
        let final = """
            #######
            #G....#   G(200)
            #.G...#   G(131)
            #.#.#G#   G(59)
            #...#.#
            #....G#   G(200)
            #######\n
            """
        XCTAssertEqual(final, day.printableRound())
    }
    
    func testExampleCombatFromExample2() {
        let input = """
            #######
            #G..#E#
            #E#E.E#
            #G.##.#
            #...#E#
            #...E.#
            #######
            """
        let day = Day15(input: input)
        
        let expected = """
            #######
            #...#E#   E(200)
            #E#...#   E(197)
            #.E##.#   E(185)
            #E..#E#   E(200), E(200)
            #.....#
            #######\n
            """
        
        XCTAssertEqual("36334", day.part1())
        XCTAssertEqual(expected, day.printableRound())
    }
    
    func testExampleCombatFromExample3() {
        let input = """
            #######
            #E..EG#
            #.#G.E#
            #E.##E#
            #G..#.#
            #..E#.#
            #######
            """
        let day = Day15(input: input)
        
        let expected = """
            #######
            #.E.E.#   E(164), E(197)
            #.#E..#   E(200)
            #E.##.#   E(98)
            #.E.#.#   E(200)
            #...#.#
            #######\n
            """
        
        XCTAssertEqual("39514", day.part1())
        XCTAssertEqual(expected, day.printableRound())
    }
    
    func testExampleCombatFromExample4() {
        let input = """
            #######
            #E.G#.#
            #.#G..#
            #G.#.G#
            #G..#.#
            #...E.#
            #######
            """
        let day = Day15(input: input)
        
        let expected = """
            #######
            #G.G#.#   G(200), G(98)
            #.#G..#   G(200)
            #..#..#
            #...#G#   G(95)
            #...G.#   G(200)
            #######\n
            """
        
        XCTAssertEqual("27755", day.part1())
        XCTAssertEqual(expected, day.printableRound())
    }

    func testExampleCombatFromExample5() {
        let input = """
            #######
            #.E...#
            #.#..G#
            #.###.#
            #E#G#G#
            #...#G#
            #######
            """
        let day = Day15(input: input)
        
        let expected = """
            #######
            #.....#
            #.#G..#   G(200)
            #.###.#
            #.#.#.#
            #G.G#G#   G(98), G(38), G(200)
            #######\n
            """
        
        XCTAssertEqual("28944", day.part1())
        XCTAssertEqual(expected, day.printableRound())
    }
    
    func testExampleCombatFromExample6() {
        let input = """
            #########
            #G......#
            #.E.#...#
            #..##..G#
            #...##..#
            #...#...#
            #.G...G.#
            #.....G.#
            #########
            """
        let day = Day15(input: input)
        
        let expected = """
            #########
            #.G.....#   G(137)
            #G.G#...#   G(200), G(200)
            #.G##...#   G(200)
            #...##..#
            #.G.#...#   G(200)
            #.......#
            #.......#
            #########\n
            """
        
        XCTAssertEqual("18740", day.part1())
        XCTAssertEqual(expected, day.printableRound())
    }
    
    private func sortedUnits(_ units: [AOC2018.Unit], byRace race: AOC2018.Unit.Race) -> [AOC2018.Unit] {
        return units.sorted(by: { $0.position < $1.position }).filter { $0.race == race }
    }
}
