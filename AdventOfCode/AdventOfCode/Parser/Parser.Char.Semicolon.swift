extension Parser where Input == Substring, Output == Character {
	public static let semicolon = Parser.char
		.flatMap { $0 == ";" ? .always(()) : .never }
}
