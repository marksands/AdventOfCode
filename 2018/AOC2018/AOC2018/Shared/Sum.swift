extension Collection where Element == Int {
    public func sum() -> Int {
        return reduce(0, +)
    }
}
