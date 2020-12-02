extension T6 where B: TupleType, B.B: TupleType, B.B.B: TupleType, B.B.B.B: TupleType {
	public func map<C, D, E, F, G, H>(_ f: ((A, B.A, B.B.A, B.B.B.A, B.B.B.B.A, B.B.B.B.B) -> (C, D, E, F, G, H))) -> T6<C, D, E, F, G, H> {
		let result = f(first,
					   second.first,
					   second.second.first,
					   second.second.second.first,
					   second.second.second.second.first,
					   second.second.second.second.second)
		return T6<C, D, E, F, G, H>(result.0, T5(result.1, T4(result.2, T3(result.3, T2(result.4, result.5)))))
	}
	
	public func mapValue<C>(_ f: ((A, B.A, B.B.A, B.B.B.A, B.B.B.B.A, B.B.B.B.B) -> (C))) -> C {
		return f(first,
				 second.first,
				 second.second.first,
				 second.second.second.first,
				 second.second.second.second.first,
				 second.second.second.second.second)
	}
}
