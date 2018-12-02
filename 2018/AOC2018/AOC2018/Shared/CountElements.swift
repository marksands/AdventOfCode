extension Sequence where Element: Hashable {
    func countElements() -> [Element: Int] {
        return Dictionary(grouping: self, by: { $0 }).mapValues({ $0.count })
    }
}
