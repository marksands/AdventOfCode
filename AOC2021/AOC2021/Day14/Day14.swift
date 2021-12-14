import Foundation
import AdventOfCode

public final class Day14: Day {
	var polymer: String
	var pairMappings: [String: String] = [:]
	
	public init(input: String = Input().trimmedRawInput()) {
		polymer = input.lines[0]
		
		for pairLine in input.components(separatedBy: "\n\n")[1].lines {
			let components = pairLine.components(separatedBy: " -> ")
			pairMappings[String(components.first!)] = String(components.last!)
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
		
		var counter: [String: Int] = [:]
		for value in polymer.exploded() {
			counter[value, default: 0] += 1
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
				
				// - track newly inserted character count
				counter[spawnedValue, default: 0] += pairCount
				
				// - decrement existing spawns
				copy[pair, default: 0] -= pairCount
			}
			
			reactions = copy
		}

		let sortedCounts = counter.sorted(by: { $0.value > $1.value })
		return (sortedCounts.first!.value - sortedCounts.last!.value).string
	}
}
