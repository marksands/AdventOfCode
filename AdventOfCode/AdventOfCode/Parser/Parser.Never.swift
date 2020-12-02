extension Parser {
	public static var never: Self {
		Self { _ in nil }
	}
}
