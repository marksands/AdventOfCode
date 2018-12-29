public func distance(from s1: String, to s2: String) -> Int {
    return zip(s1.indices, s2.indices).count(where: { s1[$0] != s2[$1] })
}
