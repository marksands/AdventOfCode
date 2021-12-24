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
		let origin = scanners[0]
		let remaining = Array(scanners.dropFirst())
		var absoluteBeacons: Set<Position> = Set(origin.positions)
		var computed: Set<Int> = [origin.id]
		
		for _ in (0..<(remaining.count)) {
			for cur in remaining where !computed.contains(cur.id) {
				if let transformed = cur.allPossibleScanners().first(where: {
					self.commonBeaconCount(absoluteBeacons, $0).0 >= 12
				}) {
					let c = self.commonBeaconCount(absoluteBeacons, transformed).1
					c.forEach { absoluteBeacons.insert($0) }
					computed.insert(transformed.id)
					break
				}
			}
		}
		
		return absoluteBeacons.count.string
    }

    public override func part2() -> String {
		return ""
    }

	public func commonBeaconCount(_ allBeacons: Set<Position>, _ current: Scanner) -> (Int, [Position]) {
		for outer in allBeacons {
			for inner in current.positions {
				let delta = inner.translation(to: outer)
				let scanner = current.scannerByTranslatingPositions(by: delta)
				let count = Set(scanner.positions).intersection(allBeacons).count
				if count >= 12 {
					return (count, scanner.positions)
				}
			}
		}

		return (-1, [])
	}
}
