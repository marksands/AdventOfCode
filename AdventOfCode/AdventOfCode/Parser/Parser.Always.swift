extension Parser {
	public static func always(_ output: Output) -> Self {
		Self { _ in output }
	}
}
