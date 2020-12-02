extension Parser {
	public func take<NewOutput>(_ p: Parser<Input, NewOutput>) -> Parser<Input, T2<Output, NewOutput>> {
		return zip(self, p)
	}
}

extension Parser {
	public func take<NewOutput>(_ p: Parser<Input, NewOutput>) -> Parser<Input, NewOutput> where Output == Void {
		return zip(self, p).take2()
	}
}
