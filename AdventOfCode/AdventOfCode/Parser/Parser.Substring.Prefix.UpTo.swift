extension Parser where Input == Substring, Output == Substring {
	public static func prefix(upTo substring: Substring) -> Self {
		Self { input in
			guard let endIndex = input.range(of: substring)?.lowerBound
			else { return nil }
			
			let match = input[..<endIndex]
			
			input = input[endIndex...]
			
			return match
		}
	}
}
