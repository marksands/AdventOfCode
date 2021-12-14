import Foundation
import AdventOfCode

public final class Day14: Day {
	var polymer: String
	var pairMappings: [String: String] = [:]
	
	public init(input: String = Input().trimmedRawInput()) {
		polymer = input.lines[0]
		
		for pairLine in input.groups[1].lines {
			pairMappings[pairLine.words.first!] = pairLine.words.last
		}
		super.init()
	}
	
    public override func part1() -> String {
		return react(steps: 10)
	}
	
	public override func part2() -> String {
		return react(steps: 40)
    }
	
	func react(steps: Int) -> String {
		var reactions: [String: Int] = [:]
		for pair in polymer.eachPair() {
			reactions[String(pair.0) + String(pair.1), default: 0] += 1
		}

		for _ in (0..<steps) {
			var copy = reactions
			for (pair, value) in reactions {
				if value <= 0 { continue }
				
				// - get existing pair count to bulk apply reaction
				let pairCount = reactions[pair]!
				
				// - split existing pair
				let spawnedValue = pairMappings[pair]!
				let spawnA = String(pair.exploded()[0]) + spawnedValue
				let spawnB = spawnedValue + String(pair.exploded()[1])
				
				// - new spawn will occur as many times as there are pairs
				copy[spawnA, default: 0] += pairCount
				copy[spawnB, default: 0] += pairCount

				// - decrement existing spawns
				copy[pair, default: 0] -= pairCount
			}
			
			reactions = copy
		}
		
		// only count the newly inserted value (position 0)
		// + the very last polymer in our original string
		var counter = [polymer.exploded().last!: 1]
		for (k, v) in reactions {
			counter[k.exploded()[0], default: 0] += v
		}

		return (counter.values.max()! - counter.values.min()!).string
	}
}
