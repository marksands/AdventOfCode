extension Collection where Element: BinaryInteger {
    public func sum() -> Element {
        return reduce(into: 0, +=)
    }
}
