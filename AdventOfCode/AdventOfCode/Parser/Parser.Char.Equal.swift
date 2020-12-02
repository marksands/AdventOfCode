extension Parser where Input == Substring, Output == Character {
	public static let equal = Parser.char
		.flatMap { $0 == "=" ? .always(()) : .never }
}
