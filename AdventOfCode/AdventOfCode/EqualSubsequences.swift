extension RangeReplaceableCollection where Element: Equatable {
    public func equalSubsequences() -> [SubSequence] {
        return reduce(into: []) { seed, result in
            if !(seed.last?.contains(result) ?? false) {
                seed.append(SubSequence())
            }
            seed[seed.count - 1].append(result)
        }
    }
}
