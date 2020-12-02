public func zip<A, B, C, D, E, F, Input>(
	_ a: Parser<Input, A>,
	_ b: Parser<Input, B>,
	_ c: Parser<Input, C>,
	_ d: Parser<Input, D>,
	_ e: Parser<Input, E>,
	_ f: Parser<Input, F>
) -> Parser<Input, T6<A, B, C, D, E, F>> {
	zip(a, zip(b, c, d, e, f))
}
