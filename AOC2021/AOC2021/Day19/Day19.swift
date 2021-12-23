import Foundation
import AdventOfCode

public final class Day19: Day {
	public struct Scanner: Equatable, CustomDebugStringConvertible {
		public let id: Int
		public let origin: Position
		public let positions: [Position]

		public init(id: Int, origin: Position = .zero, positions: [Position]) {
			self.id = id
			self.origin = origin
			self.positions = positions
		}

		public var debugDescription: String {
			return "{ \(id): \(positions) }"
		}
		
		public func scannerByTranslatingPositions(by translation: Position) -> Scanner {
			return Scanner(id: id, origin: translation, positions: positions.map { $0 + translation })
		}

		public func allPossibleScanners() -> [Scanner] {
			let positions: [[Position]] = (0..<24).reduce([]) { result, idx in
				let transformedPositions = self.positions.map { (p: Position) -> Position in
					p.allRotationsIn3D()[idx]
				}
				return result + [transformedPositions]
			}

			let scanners = positions.map { Scanner(id: id, positions: $0) }
			return scanners
		}
	}

	private let input: String
	private var scanners: [Scanner]

	public init(input: String = Input().trimmedRawInput()) {
		self.input = input
		self.scanners = input.groups.reduce([]) { array, group in
			let id = group.lines[0].int
			let positions = group.lines.dropFirst()
				.map { $0.components(separatedBy: ",").map { Int($0)! } }
				.reduce([]) { $0 + [Position(x: $1[0], y: $1[1], z: $1[2])] }
			return array + [Scanner(id: id, positions: positions)]
		}
	}

	// new idea:
	// exhaustively find the scanner that matches against scanner-0,
	// then use those beacons as the "world", where each scanner must then match against that.
	// I think my problem is the pre-seed, where I need to segment the origin scanner versus the rest.
	// That way all of my positions will be offset against scanner0, and the points will be unique such
	// that they're absolute with respect to scanner 0.
	//
	// in other words,
	// 1. I pre-compute the absoluteBeacons for scanner0. (which are just all of its beacons)
	// 2. Then I take the _other_ scanners and find the transformation that matches against those 12, removing the
	// scanner from the list each time, since it'll require pruning the scanners so I don't get duplicate matches.
	// 3. Then I should have the array for all beacons. I then unique the array and return the count as a string.
	//
    public override func part1() -> String {
		var transformedScanners: [Scanner] = []
		var computed: Set<Int> = []
		
		let origin = scanners[0]
		var remaining = Array(scanners.dropFirst())
		var absoluteBeacons: [Position] = origin.positions
		
		for index in (0..<(remaining.count)) {
			for cur in remaining where !computed.contains(cur.id) {
				if let transformed = cur.allPossibleScanners().first(where: {
					self.commonBeaconCount(absoluteBeacons, $0).0 >= 12
				}) {
					//transformedScanners.append(transformed)
					let c = self.commonBeaconCount(absoluteBeacons, transformed).1
					print("count: \(c.count)")
					absoluteBeacons.append(contentsOf: c)
					computed.insert(transformed.id)
					break
				}
			}
		}
		
		// DEBUG LIST OF BEACONS
//		let sorted = absoluteBeacons.unique().sorted(by: { ($0.x, $0.y, $0.z) < ($1.x, $1.y, $1.z) })
//		for p in sorted {
//			print("\(p.x),\(p.y),\(p.z)")
//		}
		
		return absoluteBeacons.unique().count.string
    }

    public override func part2() -> String {
		return ""
    }

	/// this is O(n^3)—slow!
	public func commonBeaconCount(_ allBeacons: [Position], _ current: Scanner) -> (Int, [Position]) {
		for outer in allBeacons {
			for inner in current.positions {
				let delta = inner.translation(to: outer)
				let scanner = current.scannerByTranslatingPositions(by: delta)
				let count = scanner.positions.intersection(of: allBeacons).count
				if count >= 12 {
					return (count, scanner.positions)
				}
			}
		}

		return (-1, [])
	}
}
