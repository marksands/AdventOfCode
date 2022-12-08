import Foundation
import AdventOfCode

public final class Day22: Day {
	struct Cuboid: Hashable {
		var x: ClosedRange<Int>
		var y: ClosedRange<Int>
		var z: ClosedRange<Int>
		var on: Bool
	}
	
	var cuboids: [Cuboid] = []

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		let regex = Regex(pattern: "^(on|off) x=(-?\\d+)..(-?\\d+),y=(-?\\d+)..(-?\\d+),z=(-?\\d+)..(-?\\d+)$")

		for line in input {
			let matches = regex.matches(in: line)!.matches
			let x = (Int(matches[2])!...Int(matches[3])!)
			let y = (Int(matches[4])!...Int(matches[5])!)
			let z = (Int(matches[6])!...Int(matches[7])!)
			let cuboid = Cuboid(x: x, y: y, z: z, on: matches[1] == "on")
			cuboids.append(cuboid)
		}

		print(cuboids)
	}

    public override func part1() -> String {
		func withinLimit(_ cuboid: Cuboid) -> Bool {
			return cuboid.x.lowerBound >= -50 && cuboid.x.upperBound <= 50 &&
			cuboid.y.lowerBound >= -50 && cuboid.y.upperBound <= 50 &&
			cuboid.z.lowerBound >= -50 && cuboid.z.upperBound <= 50
		}
		
		var cubes: [Position: Bool] = [:]
		
		for cuboid in cuboids where withinLimit(cuboid) {
            for z in cuboid.z {
                for y in cuboid.y {
                    for x in cuboid.x {
                        cubes[Position(x: x, y: y, z: z)] = cuboid.on
                    }
                }
            }
		}

		return cubes.values.count(where: { $0 }).string
    }

    public override func part2() -> String {
		var cubes: [Position: Bool] = [:]
		
		for cuboid in cuboids {
            for z in cuboid.z {
                for y in cuboid.y {
                    for x in cuboid.x {
                        cubes[Position(x: x, y: y, z: z)] = cuboid.on
                    }
                }
            }
		}

		return cubes.values.count(where: { $0 }).string
    }

	// For a 2D Plane, with an on/off sequence:
	// on x=0..2,y=0..2
	// off x=1..3,y=1..3
	// xxx- => xxx
	// x000 => x--
	// x000 => x--
	// -000 =>
	//
	// 9 - 4 => 5
	//
	// The volume is: the volume of the /on/ minus the volum of the /off/ intersection.
	// Therefore, the intersection is:
	// the minimum of the max-axis minus the maximum of the minimum-axis
	// across all axes.
	func cuboidVolumeIntersection(_ a: Cuboid, _ b: Cuboid) -> Int {
		let minMaxX = min(a.x.upperBound, b.x.upperBound)
		let maxMinX = max(a.x.lowerBound, b.x.lowerBound)

		let minMaxY = min(a.y.upperBound, b.y.upperBound)
		let maxMinY = max(a.y.lowerBound, b.y.lowerBound)

		let minMaxZ = min(a.z.upperBound, b.z.upperBound)
		let maxMinZ = max(a.z.lowerBound, b.z.lowerBound)
		
		// (2 - 1) * (2 - 1) => (1 * 1)
		
		let intersectionVolume = (minMaxX - maxMinX) * (minMaxY - maxMinY) * (minMaxZ - maxMinZ)
		return intersectionVolume
	}

	func cuboidsIntersect(_ a: Cuboid, _ b: Cuboid) -> Bool {
		return (a.x.lowerBound <= b.x.upperBound && a.x.upperBound >= b.x.lowerBound) &&
				(a.y.lowerBound <= b.y.upperBound && a.y.upperBound >= b.y.lowerBound) &&
				(a.z.lowerBound <= b.z.upperBound && a.z.upperBound >= b.z.lowerBound)
	}
}
