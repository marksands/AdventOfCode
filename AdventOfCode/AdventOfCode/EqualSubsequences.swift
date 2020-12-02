extension RangeReplaceableCollection where Element: Equatable {

	/// Returns an array of subsequences separated by components of equal elements.
	///
	/// For Example:
	///
	/// 	let array = [1, 1, 2, 1, 1, 2, 2, 2, 3, 4, 4, 5]
	///
	/// 	// [[1, 1], [2], [1, 1], [2, 2, 2], [3], [4, 4], [5]]
	/// 	array.equalSubsequences()
	///
	/// - Returns: An array of subsequences.
    public func equalSubsequences() -> [SubSequence] {
        return reduce(into: []) { seed, result in
            if seed.last?.first != result {
                seed.append(SubSequence())
            }
            seed[seed.count - 1].append(result)
        }
    }
}
