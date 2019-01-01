extension Array where Element: Equatable {
    public func equalSubsequences() -> [SubSequence] {
        return reduce(into: []) { seed, result in
            if seed.last?.last == result {
                seed[seed.count-1] = seed.last! + [result]
            } else {
                seed.append([result])
            }
        }
    }
}

extension String {
    public func equalSubsequences() -> [Substring] {
        return reduce(into: []) { seed, result in
            if seed.last?.last == result {
                seed[seed.count-1] = seed.last! + [result]
            } else {
                seed.append(Substring(String(result)))
            }
        }
    }
}
