extension Parser {
	public func map<NewOutput>(_ f: @escaping (Output) -> NewOutput) -> Parser<Input, NewOutput> {
		.init { input in
			self.run(&input).map(f)
		}
	}
}
