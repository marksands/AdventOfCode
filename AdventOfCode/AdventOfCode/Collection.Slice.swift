public extension Collection {
    func indexed() -> [(index: Index, element: Element)] {
        return zip(indices, self).map({ (index: $0, element: $1) })
    }

    func slice(between predicate: (Element, Element) -> Bool) -> [SubSequence] {
        let innerSlicingPoints = self
            .indexed()
            .eachPair()
            .map({ (indexAfter: $0.1.index, shouldSlice: predicate($0.0.element, $0.1.element)) })
            .filter({ $0.shouldSlice })
            .map({ $0.indexAfter })

        let slicingPoints = [self.startIndex] + innerSlicingPoints + [self.endIndex]

        return slicingPoints
            .eachPair()
            .map({ self[$0..<$1] })
    }

    func slice(before predicate: (Element) -> Bool) -> [SubSequence] {
        return self.slice(between: { left, right in
            return predicate(right)
        })
    }

    func slice(after predicate: (Element) -> Bool) -> [SubSequence] {
        return self.slice(between: { left, right in
            return predicate(left)
        })
    }
}
