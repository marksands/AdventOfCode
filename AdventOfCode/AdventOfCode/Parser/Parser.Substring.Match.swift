extension Parser where Input == Substring, Output == String {
	public static func match(_ substring: String) -> Self {
		Self { input in
			guard input.hasPrefix(substring) else { return nil }
			return substring
		}
	}
}
