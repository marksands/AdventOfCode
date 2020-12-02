extension Parser where Input == Substring, Output == Character {
	public static let char = Self { input in
		guard !input.isEmpty else { return nil }
		return input.removeFirst()
	}
}
