extension Collection where Element: Numeric {
	public func product(_ transform: (Element) -> Element = { $0 }) -> Element {
		return reduce(into: 1) { result, element in
			result *= transform(element)
		}
	}
}
