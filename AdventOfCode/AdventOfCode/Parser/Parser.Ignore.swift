extension Parser {
	public var ignore: Parser<Input, Output?> {
		map { _ in nil }
	}
}
