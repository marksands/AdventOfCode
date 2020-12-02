extension Parser where Input == Substring, Output == Character {
	public static let openParen = Parser.char
		.flatMap { $0 == "(" ? .always(()) : .never }

	public static let closedParen = Parser.char
		.flatMap { $0 == ")" ? .always(()) : .never }
}
