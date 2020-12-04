extension Parser: ExpressibleByUnicodeScalarLiteral where Input == Substring, Output == Void {
	public typealias UnicodeScalarLiteralType = StringLiteralType
}

extension Parser: ExpressibleByExtendedGraphemeClusterLiteral where Input == Substring, Output == Void {
	public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
}

extension Parser: ExpressibleByStringLiteral where Input == Substring, Output == Void {
	public typealias StringLiteralType = String
	
	public init(stringLiteral value: String) {
		self = Parser.prefix(value[...])
	}
}
