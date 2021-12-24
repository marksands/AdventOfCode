import Foundation
import AdventOfCode

public final class Day19: Day {
	public struct Scanner: Equatable {
		public let id: Int
		public let origin: Position
		public let positions: [Position]

		public init(id: Int, origin: Position = .zero, positions: [Position]) {
			self.id = id
			self.origin = origin
			self.positions = positions
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

    public override func part1() -> String {
		return run().part1.count.string
	}
	
	public override func part2() -> String {
		let scannerLocations = run().part2
		return scannerLocations.combinations(of: 2)
			.map { $0[0].manhattanDistance(to: $0[1]) }
			.max()!
			.string
	}
	
	private func run() -> (part1: Set<Position>, part2: [Position]) {
		let origin = scanners[0]
		let remaining = Array(scanners.dropFirst())
		var absoluteBeacons: Set<Position> = Set(origin.positions)
		var computed: Set<Int> = [origin.id]
		var deltas: [Position] = [.zero]
		
		// for every scanner, brute force all possible rotations and check the intersection of beacons.
		// If we see >= 12 in common, then we capture those beacons _at_ that rotation with the delta offset.
		// Capturing all beacons relative to the origin (0, 0, 0) allows us to uniquely prune duplicates and
		// sets up part 2 to calculate the delta extremes.

		for _ in (0..<(remaining.count)) {
			for cur in remaining where !computed.contains(cur.id) {
				if let transformed = cur.allPossibleScanners().first(where: {
					self.computedBeaconIntersection(absoluteBeacons, $0).0 >= 12
				}) {
					let (_, beacons, delta) = self.computedBeaconIntersection(absoluteBeacons, transformed)
					beacons.forEach { absoluteBeacons.insert($0) }
					computed.insert(transformed.id)
					deltas.append(delta)
					break
				}
			}
		}
		
		return (absoluteBeacons, deltas)
    }

	// returns the intersection count, beacons with their adjusted offsets, and the translation offset
	private func computedBeaconIntersection(_ allBeacons: Set<Position>, _ current: Scanner) -> (Int, [Position], Position) {
		for outer in allBeacons {
			for inner in current.positions {
				let delta = inner.translation(to: outer)
				let scanner = current.scannerByTranslatingPositions(by: delta)
				let count = Set(scanner.positions).intersection(allBeacons).count
				if count >= 12 {
					return (count, scanner.positions, delta)
				}
			}
		}

		return (-1, [], .zero)
	}
}
