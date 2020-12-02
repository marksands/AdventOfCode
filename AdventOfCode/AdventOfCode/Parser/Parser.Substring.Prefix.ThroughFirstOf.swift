extension Parser where Input == Substring, Output == Substring {
	public static func prefix(throughFirstOf substrings: [Substring]) -> Self {
		Self { input in
			let inputMatcher = input
			guard let endIndex = substrings.lazy.compactMap({ inputMatcher.range(of: $0) }).first?.upperBound else { return nil }
			
			let match = input[..<endIndex]
			
			input = input[endIndex...]
			
			return match
		}
	}
}
