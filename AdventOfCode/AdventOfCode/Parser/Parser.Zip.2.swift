public func zip<A, B, Input>(
	_ a: Parser<Input, A>,
	_ b: Parser<Input, B>
) -> Parser<Input, (A, B)> {
	.init { input -> (A, B)? in
		let original = input
		guard let output1 = a.run(&input) else { return nil }
		guard let output2 = b.run(&input) else {
			input = original
			return nil
		}
		return (output1, output2)
	}
}
