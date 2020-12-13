import Foundation

public enum Heading {
	case north
	case south
	case east
	case west

	public mutating func turnLeft() {
		switch self {
		case .north: self = .west
		case .east: self = .north
		case .south: self = .east
		case .west: self = .south
		}
	}

	public mutating func turnRight() {
		switch self {
		case .north: self = .east
		case .east: self = .south
		case .south: self = .west
		case .west: self = .north
		}
	}
}

// TODO: InfiniteMatrix?

public class Matrix<Value: Hashable>: Equatable, Hashable {
	private let rowCount: Int
	private let columnCount: Int
	private var positionsToValue: [Position: Value] = [:]
	private var data: [[Value]]

	public init(_ input: [[Value]]) {
		rowCount = input.count
		columnCount = input.first?.count ?? 0
		data = input

		for (y, row) in input.enumerated() {
			for (x, element) in row.enumerated() {
				positionsToValue[Position(x: x, y: y)] = element
			}
		}
	}

	public var positions: [Position: Value] {
		return positionsToValue
	}

	// MARK: - Hashable

	public static func == (lhs: Matrix<Value>, rhs: Matrix<Value>) -> Bool {
		return lhs.positionsToValue	== rhs.positionsToValue
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(positionsToValue)
	}

	// MARK: - Filler

	public func copy() -> Matrix<Value> {
		return Matrix(data)
	}

	public subscript(_ position: Position) -> Value {
		get {
			return positionsToValue[position]!
		}
		set {
			positionsToValue[position] = newValue
			data[position.y][position.x] = newValue
		}
	}

	// MARK: - API

	public func lineOfSightNeighbors(from position: Position, matching predicate: (Value) -> Bool) -> [Value] {
		return Position.surroundingDirections
			.compactMap { neighbor in
				return positionsToValue.firstWhile(from: position, along: neighbor, { element in
					return !predicate(element)
				})
			}
			.compactMap { positionsToValue[$0] }
	}

	public func neighbors(from position: Position, matching predicate: (Value) -> Bool) -> [Value] {
		return Position.surroundingDirections
			.compactMap { position + $0 }
			.compactMap { positionsToValue[$0] }
	}
}

extension Matrix: CustomDebugStringConvertible {
	public var debugDescription: String {
		"[" + data.map { row -> String in
			"[" + row.map { String(describing: $0) }.joined() + "]"
		}.joined(separator: "\n ") + "]"
	}
}
