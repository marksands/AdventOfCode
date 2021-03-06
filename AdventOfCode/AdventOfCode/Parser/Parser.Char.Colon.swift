extension Parser where Input == Substring, Output == Character {
	public static let colon = Parser.char
		.flatMap { $0 == ":" ? .always(()) : .never }
}
