import XCTest
import AOC2015

class Day21Tests: XCTestCase {
//	func testSandbox() {
//		
//		struct Player {
//			var weapon: Int
//			var armor: Int?
//			var rings: [Int]
//		}
//		
//		var weapons = [0, 1]
//		var armors = [3, 4]
//		var rings = [5, 6, 7]
//		
//		let possiblePlayerConfiguration = [
//			weapons.combinations(of: 1),
//			armors.combinations(of: (0...1)),
//			rings.combinations(of: (0...2))
//		].map { Player(weapon: $0[0], armor: $0[1], rings: $0[2]) }
//		
//		for player in possiblePlayerConfiguration {
//			print(player)
//		}
//		print(possiblePlayerConfiguration)
//	}
//	
	func testPart1() {
		let day = Day21()
		XCTAssertEqual("", day.part1())
	}
	
	func testPart2() {
		let day = Day21()
		XCTAssertEqual("", day.part2())
	}
}
