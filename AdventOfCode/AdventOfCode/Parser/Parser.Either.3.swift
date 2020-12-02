extension Parser {
	public static func either<A, B, C>(
		_ a: Parser<Input, A>,
		_ b: Parser<Input, B>,
		_ c: Parser<Input, C>
	) -> Parser<Input, Output> where Output == (A?, B?, C?) {
		Self { input in
			let original = input

			if let output1 = a.run(&input) {
				return (output1, nil, nil)
			}

			if let output2 = b.run(&input) {
				return (nil, output2, nil)
			}

			if let output3 = c.run(&input) {
				return (nil, nil, output3)
			}

			input = original
			return nil
		}
	}
}
