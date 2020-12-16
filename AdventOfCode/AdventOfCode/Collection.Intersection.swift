import Foundation

extension Collection where Element: Hashable {
	/// Returns a new collection with the elements that are common to both this collection and the given collection.
	///
	/// In the following example, the bothNeighborsAndEmployees collection is made up of the elements that are in both the employees and
	/// neighbors collections. Elements that are in only one or the other are left out of the result of the intersection.
	///
	/// 	let employees: Set = ["Alicia", "Bethany", "Chris", "Diana", "Eric"]
	/// 	let neighbors = ["Bethany", "Eric", "Forlani", "Greta"]
	/// 	let bothNeighborsAndEmployees = employees.intersection(neighbors)
	/// 	print(bothNeighborsAndEmployees)
	/// 	// Prints "["Bethany", "Eric"]"
	///
	/// Complexity: O(n)
	public func intersection<C: Collection>(of other: C) -> Array<Element> where C.Element == Element {
		var results: [Element] = []
		for element in self {
			if other.contains(element) {
				results.append(element)
			}
		}
		return results
	}

	/// Returns true if all of the elements in the collection are contained within the other collection
	///
	/// Complexity: O(n)
	public func isContainedWithin<C: Collection>(_ other: C) -> Bool where C.Element == Element {
		return intersection(of: other).count == count
	}
}
