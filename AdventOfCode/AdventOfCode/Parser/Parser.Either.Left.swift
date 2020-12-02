public func left<A, B, Input>(
	_ a: Parser<Input, A>,
	_ b: Parser<Input, B>
) -> Parser<Input, A> {
	zip(a, b).take1()
}
