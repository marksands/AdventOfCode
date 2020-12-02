extension Parser where Input == Substring, Output == Character {
	public static let commaOrNewline = Parser.char
		.flatMap { $0 == "," || $0 == "\n" ? .always(()) : .never }
}
