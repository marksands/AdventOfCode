extension Parser {
	public func skip<A>(_ p: Parser<Input, A>) -> Self {
		zip(self, p).map { $0.0 }
	}
}

extension Parser where Output == Void {
	public static func skip<A>(_ p: Parser<Input, A>) -> Parser<Input, Void> {
		return p.map { _ in () }
	}
}
