extension Parser {
	public func compactMap<NewOutput>(_ f: @escaping (Output) -> NewOutput?) -> Parser<Input, NewOutput> {
		.init { input in
			if let output = self.run(&input) {
				return f(output)
			}
			return nil
		}
	}
}
