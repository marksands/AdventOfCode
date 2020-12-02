public func intersection(of s1: String, and s2: String) -> String {
	return String(zip(s1.indices, s2.indices).filter({ s1[$0] == s2[$1] }).map({ s1[$0.0] }))
}

extension String {
	public func intersection(with rhs: String) -> String {
		return String(zip(indices, rhs.indices).filter({ self[$0] == rhs[$1] }).map({ self[$0.0] }))
	}
}
