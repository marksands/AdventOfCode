extension T5 where B: TupleType, B.B: TupleType, B.B.B: TupleType {
	public func map<C, D, E, F, G>(_ f: ((A, B.A, B.B.A, B.B.B.A, B.B.B.B) -> (C, D, E, F, G))) -> T5<C, D, E, F, G> {
		let result = f(first, second.first, second.second.first, second.second.second.first, second.second.second.second)
		return T5<C, D, E, F, G>(result.0, T4(result.1, T3(result.2, T2(result.3, result.4))))
	}
	
	public func mapValue<C>(_ f: ((A, B.A, B.B.A, B.B.B.A, B.B.B.B) -> (C))) -> C {
		return f(first, second.first, second.second.first, second.second.second.first, second.second.second.second)
	}
}
