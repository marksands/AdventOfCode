extension T4 where B: TupleType, B.B: TupleType {
	public func map<C, D, E, F>(_ f: ((A, B.A, B.B.A, B.B.B) -> (C, D, E, F))) -> T4<C, D, E, F> {
		let result = f(first, second.first, second.second.first, second.second.second)
		return T4<C, D, E, F>(result.0, T3(result.1, T2(result.2, result.3)))
	}
	
	public func mapValue<C>(_ f: ((A, B.A, B.B.A, B.B.B) -> (C))) -> C {
		return f(first, second.first, second.second.first, second.second.second)
	}
}
