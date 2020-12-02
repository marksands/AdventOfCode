public func zip<A, B, C, D, E, F, G, Input>(
	_ a: Parser<Input, A>,
	_ b: Parser<Input, B>,
	_ c: Parser<Input, C>,
	_ d: Parser<Input, D>,
	_ e: Parser<Input, E>,
	_ f: Parser<Input, F>,
	_ g: Parser<Input, G>
) -> Parser<Input, T7<A, B, C, D, E, F, G>> {
	zip(a, zip(b, c, d, e, f, g))
}
