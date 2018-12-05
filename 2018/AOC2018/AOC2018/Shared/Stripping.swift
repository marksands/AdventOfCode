extension String {
    public func stripping(_ character: String) -> String {
        return exploded().filter({ $0 != character }).joined()
    }
}
