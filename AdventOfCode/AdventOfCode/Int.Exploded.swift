extension Int {
	public func exploded() -> [Int] {
		return String(self).exploded().compactMap(Int.init)
	}
}
