public func zip<A, B, C, Input>(
	_ a: Parser<Input, A>,
	_ b: Parser<Input, B>,
	_ c: Parser<Input, C>
) -> Parser<Input, T3<A, B, C>> {
	zip(a, zip(b, c))
}
