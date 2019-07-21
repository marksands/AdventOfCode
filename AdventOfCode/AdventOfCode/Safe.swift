extension Collection {
    public subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array {
    public subscript (safe range: Range<Int>) -> ArraySlice<Element>? {
        return indices.count >= range.upperBound ? self[range] : nil
    }
    
    public subscript (circularly index: Index) -> Iterator.Element {
        return self[(index % count + count) % count]
    }
}
