public protocol TupleType {
	associatedtype A
	associatedtype B
	
	var first: A { get }
	var second: B { get }
}

public struct Tuple<A, B>: TupleType {
	public let first: A
	public let second: B
	
	public init(_ first: A, _ second: B) {
		self.first = first
		self.second = second
	}
}

public typealias T2<A, B> = Tuple<A, B>
public typealias T3<A, B, C> = Tuple<A, T2<B, C>>
public typealias T4<A, B, C, D> = Tuple<A, T3<B, C, D>>
public typealias T5<A, B, C, D, E> = Tuple<A, T4<B, C, D, E>>
public typealias T6<A, B, C, D, E, F> = Tuple<A, T5<B, C, D, E, F>>
public typealias T7<A, B, C, D, E, F, G> = Tuple<A, T6<B, C, D, E, F, G>>
