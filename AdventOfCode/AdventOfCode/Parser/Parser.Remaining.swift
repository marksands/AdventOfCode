extension Parser where Input == Substring, Output == Substring {
	public static var remaining: Self {
		Parser.prefix(while: { _ in true })
	}
}
