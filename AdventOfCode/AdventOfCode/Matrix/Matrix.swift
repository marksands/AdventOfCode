import Foundation

public enum Heading {
	case north
	case south
	case east
	case west

	mutating func turnLeft() {
		switch self {
		case .north: self = .west
		case .east: self = .north
		case .south: self = .east
		case .west: self = .south
		}
	}

	mutating func turnRight() {
		switch self {
		case .north: self = .east
		case .east: self = .south
		case .south: self = .west
		case .west: self = .north
		}
	}
}
