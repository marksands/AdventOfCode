extension Parser where Input == Substring, Output == Character {
	public static let whitespacesAndNewlines = Parser.char
		.flatMap {
			$0.unicodeScalars
				.contains(where: {
					CharacterSet.whitespacesAndNewlines.contains($0)
				}) ? Parser<Substring, Void>.always(()) : Parser<Substring, Void>.never
		}
}
