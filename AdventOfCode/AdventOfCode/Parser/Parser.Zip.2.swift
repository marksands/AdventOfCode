public func zip<A, B, Input>(
	_ a: Parser<Input, A>,
	_ b: Parser<Input, B>
) -> Parser<Input, T2<A, B>> {
	.init { input -> T2<A, B>? in
		let original = input
		guard let output1 = a.run(&input) else { return nil }
		guard let output2 = b.run(&input) else {
			input = original
			return nil
		}
		return T2(output1, output2)
	}
}
