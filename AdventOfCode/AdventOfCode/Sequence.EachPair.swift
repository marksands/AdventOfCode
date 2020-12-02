public extension Sequence {
    func eachPair() -> Zip2Sequence<Self, DropFirstSequence<Self>> {
        return zip(self, self.dropFirst())
    }
}
