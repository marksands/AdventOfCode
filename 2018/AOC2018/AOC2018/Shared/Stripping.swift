extension String {
    public func stripping(_ character: String) -> String {
        return replacingOccurrences(of: character, with: "")
    }
}
