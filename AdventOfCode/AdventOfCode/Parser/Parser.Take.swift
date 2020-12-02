extension Parser {
	public func take<NewOutput>(_ p: Parser<Input, NewOutput>) -> Parser<Input, (Output, NewOutput)> {
		return zip(self, p)
	}
}

extension Parser {
	public func take<NewOutput>(_ p: Parser<Input, NewOutput>) -> Parser<Input, NewOutput> where Output == Void {
		return zip(self, p).map { $1 }
	}
}

extension Parser {
	public func take<A, B, C>(_ c: Parser<Input, C>) -> Parser<Input, (A, B, C)> where Output == (A, B) {
		zip(self, c).map { ab, c in (ab.0, ab.1, c) }
	}

	public func take<A, B, C, D>(_ d: Parser<Input, D>) -> Parser<Input, (A, B, C, D)> where Output == (A, B, C) {
		zip(self, d).map { abc, d in (abc.0, abc.1, abc.2, d) }
	}
}
