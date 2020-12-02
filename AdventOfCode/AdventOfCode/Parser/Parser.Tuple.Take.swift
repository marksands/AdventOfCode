extension Parser where Output: TupleType {
	// MARK: - A, B
	
	public func take1<A, B>() -> Parser<Input, A> where Output == Tuple<A, B> {
		return self.map { $0.first }
	}
	
	public func take2<A, B>() -> Parser<Input, B> where Output == Tuple<A, B> {
		return self.map { $0.second }
	}
	
	// MARK: - A, B, C
	
	public func take1<A, B, C>() -> Parser<Input, A> where Output == T3<A, B, C> {
		return self.map { $0.first }
	}
	
	public func take2<A, B, C>() -> Parser<Input, B> where Output == T3<A, B, C> {
		return self.map { $0.second.first }
	}
	
	public func take3<A, B, C>() -> Parser<Input, C> where Output == T3<A, B, C> {
		return self.map { $0.second.second }
	}
	
	// MARK: - A, B, C, D
	
//	public func take1<A, B, C, D>() -> Parser<A> where Output == T4<A, B, C, D> {
//		return self.map { $0.first }
//	}
//
//	public func take2<A, B, C, D>() -> Parser<B> where Output == T4<A, B, C, D> {
//		return self.map { $0.second.first }
//	}
//
//	public func take3<A, B, C, D>() -> Parser<C> where Output == T4<A, B, C, D> {
//		return self.map { $0.second.second.first }
//	}
//
//	public func take4<A, B, C, D>() -> Parser<D> where Output == T4<A, B, C, D> {
//		return self.map { $0.second.second.second }
//	}
//
//	// MARK: - A, B, C, D, E
//
//	public func take1<A, B, C, D, E>() -> Parser<A> where Output == T5<A, B, C, D, E> {
//		return self.map { $0.first }
//	}
//
//	public func take2<A, B, C, D, E>() -> Parser<B> where Output == T5<A, B, C, D, E> {
//		return self.map { $0.second.first }
//	}
//
//	public func take3<A, B, C, D, E>() -> Parser<C> where Output == T5<A, B, C, D, E> {
//		return self.map { $0.second.second.first }
//	}
//
//	public func take4<A, B, C, D, E>() -> Parser<D> where Output == T5<A, B, C, D, E> {
//		return self.map { $0.second.second.second.first }
//	}
//
//	public func take5<A, B, C, D, E>() -> Parser<E> where Output == T5<A, B, C, D, E> {
//		return self.map { $0.second.second.second.second }
//	}
//
//	// MARK: - A, B, C, D, E, F
//
//	public func take1<A, B, C, D, E, F>() -> Parser<A> where Output == T6<A, B, C, D, E, F> {
//		return self.map { $0.first }
//	}
//
//	public func take2<A, B, C, D, E, F>() -> Parser<B> where Output == T6<A, B, C, D, E, F> {
//		return self.map { $0.second.first }
//	}
//
//	public func take3<A, B, C, D, E, F>() -> Parser<C> where Output == T6<A, B, C, D, E, F> {
//		return self.map { $0.second.second.first }
//	}
//
//	public func take4<A, B, C, D, E, F>() -> Parser<D> where Output == T6<A, B, C, D, E, F> {
//		return self.map { $0.second.second.second.first }
//	}
//
//	public func take5<A, B, C, D, E, F>() -> Parser<E> where Output == T6<A, B, C, D, E, F> {
//		return self.map { $0.second.second.second.second.first }
//	}
//
//	public func take6<A, B, C, D, E, F>() -> Parser<F> where Output == T6<A, B, C, D, E, F> {
//		return self.map { $0.second.second.second.second.second }
//	}
}
