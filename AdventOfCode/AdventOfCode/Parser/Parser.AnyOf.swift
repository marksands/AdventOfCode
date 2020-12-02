extension Parser where Input == Substring {
	public static func any(of parsers: [Self], separatedBy separator: Parser<Input, Void> = "") -> Parser<Input, [Output]> {
		Parser<Input, [Output]> { input in
			var rest = input
			var matches: [Output] = []
			while let match = Parser.oneOf(parsers).run(&input) {
				rest = input
				matches.append(match)
				if separator.run(&input) == nil {
					return matches
				}
			}
			input = rest
			return matches
		}
	}
}
