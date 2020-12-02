public func require<A, B>(_ t: T2<A?, B?>) -> T2<A, B>? {
	t.first.flatMap { f in t.second.map { T2(f, $0) } }
}

public func require<A, B>(_ t: T2<A?, B>) -> T2<A, B>? {
	t.first.map { T2($0, t.second) }
}

public func require<A, B>(_ t: T2<A, B?>) -> T2<A, B>? {
	t.second.map { T2(t.first, $0) }
}
