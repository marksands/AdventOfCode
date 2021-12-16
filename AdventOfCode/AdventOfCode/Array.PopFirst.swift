extension Array {
	public mutating func popFirst() -> Element {
		return removeFirst()
	}
	
	public mutating func popFirst(_ k: Int) -> ArraySlice<Element>.SubSequence {
		let result = prefix(k)
		removeFirst(k)
		return result
	}
}
