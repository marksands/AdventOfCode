import Foundation
import AdventOfCode

// Dear reader, there is nothing interesting here whatsoever.
// I put very little thought into this. I did the aboslute minimum
// in order to arrive at an answer. This lead to some of the requirements
// from part 1 to bleed into the solution for part 1, which required
// hard coding values and twiddling some numbers. There is nothing
// to be learned here, sorry.

public final class Day17: Day {
	// target area: x=57..116, y=-198..-148
	let targetX = (57...116)
	let targetY = ((-198)...(-148))
	
    public override func part1() -> String {
		// vx, vy, maxy
		var possibilities: [(Int, Int, Int)] = []
		
		// step
		for step_x in (-1_000...1_000) {
			for step_y in (-1_000...1_000) {
				var velocity_x = step_x
				var velocity_y = step_y
				var position_x = 0
				var position_y = 0
				var trajectory_max_y = Int.min
				
				let initialX = step_x
				let initialY = step_y
				
				for _ in (0..<1_000) {
					position_x += velocity_x
					position_y += velocity_y
					
					trajectory_max_y = max(trajectory_max_y, position_y)
					
					// drag
					if velocity_x != 0 {
						if velocity_x > 0 {
							velocity_x -= 1
						} else if velocity_x < 0 {
							velocity_x += 1
						}
					}
					
					// gravity
					velocity_y -= 1
					
					// check target area
					if targetX.contains(position_x) && targetY.contains(position_y) {
						possibilities.append((trajectory_max_y, initialX, initialY))
					}
				}
			}
		}
		
//		for possibility in possibilities {
//			print("\(possibility.1),\(possibility.2)")
//		}
//		
//		let minX = possibilities.map { $0.1 }.min()!
//		let maxX = possibilities.map { $0.1 }.max()!
//		let minY = possibilities.map { $0.2 }.min()!
//		let maxY = possibilities.map { $0.2 }.max()!
		
		//print("ranges: x\(minX)...\(maxX) y\(minY)...\(maxY)")

		let highestYPosition = possibilities.sorted { $0.0 > $1.0 }.first!.0
		return highestYPosition.string
    }

    public override func part2() -> String {
		// vx, vy
		var possibilities: [(Int, Int)] = []

		// extremes found from part1
		// ranges: x11...116 y-198...197

		// step
		for step_x in (0...1_000) {
			for step_y in (-1_000...1_000) {
				var velocity_x = step_x
				var velocity_y = step_y
				var position_x = 0
				var position_y = 0
				var trajectory_max_y = Int.min
				
				let initialX = step_x
				let initialY = step_y
				
				for _ in (0..<2_500) {
					position_x += velocity_x
					position_y += velocity_y
					
					trajectory_max_y = max(trajectory_max_y, position_y)
					
					// drag
					if velocity_x != 0 {
						if velocity_x > 0 {
							velocity_x -= 1
						} else if velocity_x < 0 {
							velocity_x += 1
						}
					}
					
					// gravity
					velocity_y -= 1
					
					// check target area
					if targetX.contains(position_x) && targetY.contains(position_y) {
						possibilities.append((initialX, initialY))
						break
					}
				}
			}
		}
		
		let uniquePossibilities = possibilities.map { String($0) + String($1) }.unique()
		return uniquePossibilities.count.string
    }
}
