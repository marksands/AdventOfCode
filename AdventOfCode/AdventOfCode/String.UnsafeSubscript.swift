extension StringProtocol {
	public subscript(unsafe index: Int) -> Character {
		let character = self[self.index(startIndex, offsetBy: index)]
		return character
	}
}
