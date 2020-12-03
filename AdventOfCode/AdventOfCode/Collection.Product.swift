extension Collection where Element: Numeric {
	public func product() -> Element {
		return reduce(into: 1, *=)
	}

	public func product(_ transform: (Element) -> Element) -> Element {
		return reduce(into: 1) { result, element in
			result *= transform(element)
		}
	}
}
