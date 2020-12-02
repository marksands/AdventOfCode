extension Parser {
	public func zeroOrMore(separatedBySequence separator: Parser<Input, Void>) -> Parser<Input, [Output]> {
		Parser<Input, [Output]> { input in
			var rest = input
			var matches: [Output] = []
			while let match = self.run(&input) {
				rest = input
				matches.append(match)
				repeat { } while separator.run(&input) != nil
			}
			input = rest
			return matches
		}
	}
}
