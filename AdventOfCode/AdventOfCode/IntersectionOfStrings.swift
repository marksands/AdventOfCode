public func intersection(of s1: String, and s2: String) -> String {
    return String(zip(s1.indices, s2.indices).filter({ s1[$0] == s2[$1] }).map({ s1[$0.0] }))
}
