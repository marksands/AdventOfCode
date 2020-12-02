extension Parser {
	public static func either<A, B>(
		_ a: Parser<Input, A>,
		_ b: Parser<Input, B>
	) -> Parser<Input, Output> where Output == Tuple<A?, B?> {
		Self { input in
			let original = input
			var copy = input

			if let output1 = a.run(&input) {
				return T2(output1, nil)
			}

			if let output2 = b.run(&copy) {
				input = copy
				return T2(nil, output2)
			}

			input = original
			return nil
		}
	}
}
