extension Parser {
	public static func either<A, B>(
		_ a: Parser<Input, A>,
		_ b: Parser<Input, B>
	) -> Parser<Input, Output> where Output == (A?, B?) {
		Self { input in
			let original = input
			var copy = input

			if let output1 = a.run(&input) {
				return (output1, nil)
			}

			if let output2 = b.run(&copy) {
				input = copy
				return (nil, output2)
			}

			input = original
			return nil
		}
	}
}
