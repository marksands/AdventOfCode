extension Collection where Element: Numeric {
	public func multiply() -> Element {
		return reduce(into: 1, *=)
	}
}
