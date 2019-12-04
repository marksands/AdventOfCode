extension String {
    public func exploded() -> [String] {
        return map(String.init)
    }
}

extension Int {
    public func exploded() -> [Int] {
        return String(self).exploded().compactMap(Int.init)
    }
}
