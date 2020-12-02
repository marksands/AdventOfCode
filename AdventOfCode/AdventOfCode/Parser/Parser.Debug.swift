extension Parser {
	public func debug(_ identifier: String? = nil) -> Parser<Input, Output> {
		.init { input in
			if let identifier = identifier {
				print("\(identifier) \(input)")
			} else {
				print("\(input)")
			}
			return self.run(&input)
		}
	}
}
