extension Collection {
    var eachWithIndex: some Sequence {
        return zip(indices, self)
    }
}
