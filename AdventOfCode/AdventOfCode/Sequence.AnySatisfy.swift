extension Sequence {
	/// Returns a Boolean value indicating whether any element of a sequence satisfies a given predicate.
	///
	/// The following code uses this method to test whether all the names in an array have at least five characters:
	///
	/// 	let names = ["Sara", "Camilla", "Martina", "Mateo", "Zoe"]
	/// 	let anyHaveAtLeastFive = names.anySatisfy({ $0.count >= 5 })
	/// 	anyHaveAtLeastFive == true
    public func anySatisfy(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        return try reduce(false) { try $0 || predicate($1) }
    }
}
