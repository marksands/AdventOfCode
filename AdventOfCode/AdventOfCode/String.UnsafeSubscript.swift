extension StringProtocol {
	public subscript(unsafe index: Int) -> Character {
		let character = self[self.index(startIndex, offsetBy: index)]
		return character
	}

	public subscript(safe index: Int) -> Character? {
		guard index >= 0 else { return nil }
		guard let newIndex = self.index(startIndex, offsetBy: index, limitedBy: endIndex) else { return nil }
		guard indices.contains(newIndex) else { return nil }
		return self[newIndex]
	}
}
