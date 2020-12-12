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

public class Matrix<Value> {
	private var positionsToValue: [Position: Value] = [:]

	public init(_ input: [[Value]]) {
		for (y, row) in input.enumerated() {
			for (x, element) in row.enumerated() {
				positionsToValue[Position(x: x, y: y)] = element
			}
		}
	}
}
