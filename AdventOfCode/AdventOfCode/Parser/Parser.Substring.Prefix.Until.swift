extension Parser where Input == Substring, Output == Substring {
	public static func prefix(until match: Parser<Input, Void>) -> Self {
		Self { input in
			var characters: [Character] = []
			while match.run(&input) == nil {
				if input.isEmpty { return nil }
				characters.append(input.removeFirst())
			}
			return Substring(characters)
		}
	}
}
