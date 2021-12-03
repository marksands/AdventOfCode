extension Sequence where Element: Hashable {
	public func mostCommonElement() -> Element {
		return countElements().max(by: { $0.value < $1.value })!.key
	}
	
	public func leastCommonElement() -> Element {
		return countElements().min(by: { $0.value < $1.value })!.key
	}
}
