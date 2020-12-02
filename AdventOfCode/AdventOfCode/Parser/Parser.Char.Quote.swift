extension Parser where Input == Substring, Output == Character {
	public static let quote = Parser.char
		.flatMap { $0 == "\"" ? .always(()) : .never }
}
