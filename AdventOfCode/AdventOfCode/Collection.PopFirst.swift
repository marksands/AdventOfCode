extension RangeReplaceableCollection {
	public mutating func popFirst() -> Element? {
		guard !isEmpty else { return nil }
		return removeFirst()
	}
}
