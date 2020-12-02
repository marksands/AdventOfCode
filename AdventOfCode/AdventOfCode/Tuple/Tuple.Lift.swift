// MARK: - Lift 1

public func lift<A>(_ t: [A]) -> A? {
	guard t.count == 1 else { return nil }
	return t[0]
}

// MARK: - Lift 2

public func lift<A>(_ t: [A]) -> T2<A, A>? {
	guard t.count == 2 else { return nil }
	return T2(t[0], t[1])
}

// MARK: - Lift 3

public func lift<A>(_ t: [A]) -> T3<A, A, A>? {
	guard t.count == 3 else { return nil }
	return T3(t[0], T2(t[1], t[2]))
}

// MARK: - Lift 4

public func lift<A>(_ t: [A]) -> T4<A, A, A, A>? {
	guard t.count == 4 else { return nil }
	return T4(t[0], T3(t[1], T2(t[2], t[3])))
}

// MARK: - Lift 5

public func lift<A>(_ t: [A]) -> T5<A, A, A, A, A>? {
	guard t.count == 5 else { return nil }
	return T5(t[0], T4(t[1], T3(t[2], T2(t[3], t[4]))))
}

// MARK: - Lift 6

public func lift<A>(_ t: [A]) -> T6<A, A, A, A, A, A>? {
	guard t.count == 6 else { return nil }
	return T6(t[0], T5(t[1], T4(t[2], T3(t[3], T2(t[4], t[5])))))
}
