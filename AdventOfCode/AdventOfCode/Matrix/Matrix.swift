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

	// MARK: - Transform

	public func rotated(_ clockwiseTurns: Int = 1) -> Matrix<Value> {
		let turns = clockwiseTurns % 4
		if turns == 0 { return Matrix(data) }

		var current = data
		for _ in (0..<turns) {
			var thisTurn: [[Value]] = []
			for i in (0..<current[0].count) {
				var newRow: [Value] = []
				for row in current.reversed() {
					newRow.append(row[i])
				}
				thisTurn.append(newRow)
			}
			current = thisTurn
		}
		return Matrix(current)
	}

	public func flippedHorizontally() -> Matrix<Value> {
		var flipped = data
		for row in data {
			flipped.append(row.reversed())
		}
		return Matrix(flipped)
	}

	public func flippedVertically() -> Matrix<Value> {
		return rotated(1).flippedHorizontally().rotated(3)
	}

	public func rotatedAndFlipped() -> [Matrix<Value>] {
		let mutations = (0...3).flatMap { i -> [Matrix<Value>] in
			let m = rotated(i)
			return [m, m.flippedHorizontally(), m.flippedVertically(), m.flippedVertically().flippedHorizontally()]
		}
		return mutations.unique()
	}

	public func insetBorders() -> Matrix<Value> {
		let copy = data.dropFirst().dropLast()
		var newData: [[Value]] = []
		for line in copy {
			newData.append(line.dropFirst().dropLast())
		}
		return Matrix(newData)
	}

	// MARK: - Combine

	/// concatenates [a] and [b] assuming the row count are the same dimension
//	func concatenate(_ a: [String], _ b: [String]) -> [String] {
//		guard a.count == b.count else { fatalError("A's row count must match B's row count!") }
//
//		let newMatrix = zip(a, b).map { left, right in
//			left + right
//		}
//
//		return newMatrix
//	}

	// MARK: - Edges

	public var topEdge: [Value] {
		data[0]
	}

	public var bottomEdge: [Value] {
		data.last!
	}

	public var leftEdge: [Value] {
		data.map { $0[0] }
	}

	public var rightEdge: [Value] {
		data.map { $0[columnCount-1] }
	}
}

extension Matrix: CustomDebugStringConvertible {
	public var debugDescription: String {
		"[" + data.map { row -> String in
			"[" + row.map { String(describing: $0) }.joined() + "]"
		}.joined(separator: "\n ") + "]"
	}
}
