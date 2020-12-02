extension Parser {
	public func run(_ input: Input) -> (match: Output?, rest: Input) {
		var input = input
		let match = self.run(&input)
		return (match, input)
	}
}
