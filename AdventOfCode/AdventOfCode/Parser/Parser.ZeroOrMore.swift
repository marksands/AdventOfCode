extension Parser where Input == Substring {
	public func zeroOrMore(separatedBy separator: Parser<Input, Void> = "") -> Parser<Input, [Output]> {
		Parser<Input, [Output]> { input in
			var rest = input
			var matches: [Output] = []
			while let match = self.run(&input) {
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
