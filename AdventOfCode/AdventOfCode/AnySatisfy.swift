extension Sequence {
    public func anySatisfy(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        return try reduce(false) { try $0 || predicate($1) }
    }
}
