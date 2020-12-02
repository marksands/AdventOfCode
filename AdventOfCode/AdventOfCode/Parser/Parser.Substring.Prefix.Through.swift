extension Parser where Input == Substring, Output == Substring {
	public static func prefix(through substring: Substring) -> Self {
		Self { input in
			guard let endIndex = input.range(of: substring)?.upperBound
			else { return nil }
			
			let match = input[..<endIndex]
			
			input = input[endIndex...]
			
			return match
		}
	}
}
