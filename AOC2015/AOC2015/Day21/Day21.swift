import Foundation
import AdventOfCode

public final class Day21: Day {
	// Weapons:    Cost  Damage  Armor
	// Dagger        8     4       0
	// Shortsword   10     5       0
	// Warhammer    25     6       0
	// Longsword    40     7       0
	// Greataxe     74     8       0
	//
	// Armor:      Cost  Damage  Armor
	// Leather      13     0       1
	// Chainmail    31     0       2
	// Splintmail   53     0       3
	// Bandedmail   75     0       4
	// Platemail   102     0       5
	//
	// Rings:      Cost  Damage  Armor
	// Damage +1    25     1       0
	// Damage +2    50     2       0
	// Damage +3   100     3       0
	// Defense +1   20     0       1
	// Defense +2   40     0       2
	// Defense +3   80     0       3
	
	struct Object {
		var name: String
		var cost: Int
		var damage: Int
		var armor: Int
	}
	
	var weapons = [
		Object(name: "Dagger", cost: 8, damage: 4, armor: 0),
		Object(name: "Shortsword", cost: 10, damage: 5, armor: 0),
		Object(name: "Warhammer", cost: 25, damage: 6, armor: 0),
		Object(name: "Longsword", cost: 40, damage: 7, armor: 0),
		Object(name: "Greataxe", cost: 74, damage: 8, armor: 0)
	]
	
	var armors = [
		Object(name: "Leather", cost: 13, damage: 0, armor: 1),
		Object(name: "Chainmail", cost: 31, damage: 0, armor: 2),
		Object(name: "Splintmail", cost: 53, damage: 0, armor: 3),
		Object(name: "Bandedmail", cost: 75, damage: 0, armor: 4),
		Object(name: "Platemail", cost: 102, damage: 0, armor: 5)
	]
	
	var rings = [
		Object(name: "Damage+1", cost: 25, damage: 1, armor: 0),
		Object(name: "Damage+2", cost: 50, damage: 2, armor: 0),
		Object(name: "Damage+3", cost: 100, damage: 3, armor: 0),
		Object(name: "Defense+1", cost: 20, damage: 0, armor: 1),
		Object(name: "Defense+2", cost: 40, damage: 0, armor: 2),
		Object(name: "Defense+3", cost: 80, damage: 0, armor: 3)
	]
	
	// Todo:
	// all permutations of:
	// 1 required weapon, 0 or 1 of armor, 0 or 2 of rings
	
	struct Player {
		var weapon: Object
		var armor: Object?
		var rings: [Object]
	}

	public init(input: String = Input().trimmedRawInput()) {
		super.init()
	}
	
	public override func part1() -> String {
//		let possiblePlayerConfiguration = [
//			weapons.combinations(of: 1).flatMap { $0 },
//			armors.combinations(of: (0...1)).flatMap { $0 },
//			rings.combinations(of: (0...2)).flatMap { $0 }
//		].permutations()
//			.map {
//			Player(weapon: $0[0], armor: $0[1], rings: $0[2])
//		}
//		
//		for itemSet in allPossibleCombinationOfItems {
//			print(ring)
//		}
//		print(potentialRings)
		
		return ":("
	}
	
	public override func part2() -> String {
		return ":("
	}
}
