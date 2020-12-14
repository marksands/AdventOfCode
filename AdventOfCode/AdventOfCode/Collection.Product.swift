extension Collection where Element: Numeric {
	public func product(_ transform: (Element) -> Element = { $0 }) -> Element {
		return reduce(into: 1) { result, element in
			result *= transform(element)
		}
	}
}

extension Collection {
	public func product<N: Numeric>(_ transform: (Element) -> N) -> N {
		return reduce(into: 1) { result, element in
			result *= transform(element)
		}
	}
}
