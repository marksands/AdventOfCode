extension T3 where B: TupleType {
	public func map<C, D, E>(_ f: ((A, B.A, B.B) -> (C, D, E))) -> T3<C, D, E> {
		let result = f(first, second.first, second.second)
		return T3<C, D, E>(result.0, T2(result.1, result.2))
	}
	
	public func mapValue<C>(_ f: ((A, B.A, B.B) -> (C))) -> C {
		return f(first, second.first, second.second)
	}
}
