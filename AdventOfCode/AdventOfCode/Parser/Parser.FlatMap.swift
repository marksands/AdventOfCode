extension Parser {
	public func flatMap<NewOutput>(_ f: @escaping (Output) -> Parser<Input, NewOutput>) -> Parser<Input, NewOutput> {
		.init { input in
			let original = input
			let output = self.run(&input)
			let newParser = output.map(f)
			guard let newOutput = newParser?.run(&input) else {
				input = original
				return nil
			}
			return newOutput
		}
	}
}
