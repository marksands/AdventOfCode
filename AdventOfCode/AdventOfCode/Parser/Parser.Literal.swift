extension Parser where Input == Substring, Output == Void {
	public static func literal(_ value: String) -> Parser<Input, Void> {
		return Parser(stringLiteral: value)
	}
}
