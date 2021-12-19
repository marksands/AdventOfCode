extension String {
	public func replacingFirstMatch(of match: String, with value: String) -> String {
		guard let range = ranges(of: match).first else { return self }
		var copy = self
		copy.replaceSubrange(range, with: value)
		return copy
	}
	
	public func replacingLastMatch(of match: String, with value: String) -> String {
		guard let range = ranges(of: match).last else { return self }
		var copy = self
		copy.replaceSubrange(range, with: value)
		return copy
	}
}
