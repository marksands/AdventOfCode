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

    public override func part1() -> String {
		var transformedScanners: [Scanner] = []
//		var absoluteBeacons: [Position] = []
		var relativeScanners: [Scanner] = []
		
		for scanner in scanners {
			for other in scanners where other != scanner {
				if let transformed = scanner.allPossibleScanners().first(where: {
					self.commonBeaconCount(other, $0).0 >= 12
				}) {
					transformedScanners.append(transformed)
					let c = self.commonBeaconCount(other, transformed).1
					relativeScanners.append(c)
					print("count: \(c.positions.count)")
					//absoluteBeacons.append(contentsOf: c)
					break
				}
			}
		}
		
		let origin = scanners[0]
		let remaining = scanners.dropFirst()
		
		// DEBUG LIST OF BEACONS
//		let sorted = absoluteBeacons.unique().sorted(by: { ($0.x, $0.y, $0.z) < ($1.x, $1.y, $1.z) })
//		for p in sorted {
//			print("\(p.x),\(p.y),\(p.z)")
//		}
		
		return ":("
    }

    public override func part2() -> String {
		return ""
    }

	/// this is O(n^3)—slow!
	public func commonBeaconCount(_ comparison: Scanner, _ current: Scanner) -> (Int, Scanner) {
		var count = -1
//		var absoluteBeacons: [Position] = []
		var relativeScanner: Scanner!
		
		for outer in comparison.positions {
			for inner in current.positions {
				let delta = inner.translation(to: outer)
				let scanner = current.scannerByTranslatingPositions(by: delta)
				let scannerCount = scanner.positions.intersection(of: comparison.positions).count
				if scannerCount > count {
					count = scannerCount
					// FIXME: these are not offset around the origin scanner's position
//					absoluteBeacons = scanner.positions
					relativeScanner = scanner
				}

				if count >= 12 {
					return (count, relativeScanner)
				}
			}
		}

		return (count, relativeScanner)
	}
}
