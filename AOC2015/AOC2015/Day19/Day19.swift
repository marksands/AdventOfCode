import Foundation
import AdventOfCode

public final class Day19: Day {
	var molecule: String
	var pairMappings: [String: [String]] = [:]
	var reversedPairMappings: [String: String] = [:]

    public init(input: String = Input().trimmedRawInput()) {
		molecule = input.groups[1]
		
		for line in input.groups[0].lines {
			pairMappings[line.words.first!, default: []] += [line.words.last!]
			reversedPairMappings[line.words.last!] = line.words.first
		}
				
        super.init()
    }

    public override func part1() -> String {
		var set: Set<String> = []
		
		for (key, values) in pairMappings {
			for value in values {
				for range in molecule.ranges(of: key) {
					var copy = molecule
					copy.replaceSubrange(range, with: value)
					set.insert(copy)
				}
			}
		}
		
		return set.count.string
    }
    
    public override func part2() -> String {
		var stack: [(String, Int)] = [(molecule, 0)]
		
		// DFS working backwrads from the final molecule to 'e'
		while let top = stack.popLast() {
			for neighbor in replacementNeighbors(from: top.0) {
				if neighbor == "e" {
					return (top.1 + 1).string
				} else {
					stack.append((neighbor, top.1 + 1))
				}
			}
		}
		
		// breaking when we find 'e' which should always succeed
		fatalError()
    }
	
	private func replacementNeighbors(from molecule: String) -> [String] {
		var set: Set<String> = []
		
		// Use reverse mappings to break down the molecule
		for (key, value) in reversedPairMappings {
			for range in molecule.ranges(of: key) {
				var copy = molecule
				copy.replaceSubrange(range, with: value)
				set.insert(copy)
			}
		}
		
		return Array(set)
	}
}
