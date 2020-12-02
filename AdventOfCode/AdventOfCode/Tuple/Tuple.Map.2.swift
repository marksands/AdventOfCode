extension T2 {
	public func map<C, D>(_ f: ((A, B) -> (C, D))) -> T2<C, D> {
		let result = f(first, second)
		return T2<C, D>(result.0, result.1)
	}
	
	public func mapValue<C>(_ f: ((A, B) -> (C))) -> C {
		return f(first, second)
	}
}
