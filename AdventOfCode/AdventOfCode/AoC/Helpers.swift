import Foundation

extension String {
	public var lines: [String] {
		components(separatedBy: "\n").filter { !$0.isEmpty }
	}

	public var groups: [String] {
		components(separatedBy: "\n\n").filter { !$0.isEmpty }
	}
	
	public var words: [String] {
		split(whereSeparator: { !$0.isLetter }).map { String($0) }
	}

    /// Returns an array of all numbers within the string as grouped integers
    ///
    /// Example: 12abc345de6f => [12,345,6]
	public var ints: [Int] {
		split(whereSeparator: { !$0.isNumber }).compactMap { Int($0) }
	}

    /// Returns an array of all numbers within the string as single digit integers
    ///
    /// Example: 12abc345de6f => [1,2,3,4,5,6]
    public var singleDigitInts: [Int] {
        split(whereSeparator: { !$0.isNumber }).joined().exploded().compactMap { Int($0) }
    }
	
	public var int: Int {
		Int(split(whereSeparator: { !$0.isNumber }).joined())!
	}
	
	public var isNumber: Bool {
		return Int(self) != nil
	}

	public func print() {
		Swift.print(self)
	}

    public var reversed: String {
        return String(reversed())
    }
}

extension Substring {
	public var ints: [Int] {
		return String(self).ints
	}
}

extension Int {
	public func print() {
		Swift.print(self)
	}
	
	public var string: String {
		return String(self)
	}
}

extension Dictionary {
	public func print() {
		Swift.print(self)
	}
}

extension Array {
	public func print() {
		Swift.print(self)
	}
}
