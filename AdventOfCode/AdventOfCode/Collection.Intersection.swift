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
	/// Complexity: O(n^2)
	public func intersection<C: Collection>(of other: C) -> Array<Element> where C.Element == Element {
		var results: [Element] = []
		for element in self {
			if other.contains(element) {
				results.append(element)
			}
		}
		return results
	}
//
//	/// Returns true if all of the elements in the collection are contained within the other collection
//	///
//	/// Complexity: O(n^2)
//	public func isContainedWithin<C: Collection>(_ other: C) -> Bool where C.Element == Element {
//		return intersection(of: other).count == count
//	}
}

extension Collection where Element: Hashable & Comparable {
	/// Returns true if all of the elements in the collection are contained within the other collection
	///
	/// 	let employees = ["Bethany", "Chris"]
	/// 	let neighbors = ["Bethany", "Chris", "Forlani", "Greta"]
	/// 	employees.isContainedWithin(neighbors) // true
	///
	/// Complexity: O(n log n), where n is the length of the sequence.
	public func isContainedWithin<C: Collection>(_ other: C) -> Bool where C.Element == Element {
		guard count > 0 else { return false }
		guard other.count > 0 else { return false }

		let sortedSelf = self.sorted()
		let sortedOther = other.sorted()

		var i = 0
		var j = 0

		var elementsEqual = 0

		while i < sortedSelf.count && j < sortedOther.count {
			if sortedSelf[i] < sortedOther[j] {
				i += 1
			} else if sortedSelf[i] > sortedOther[j] {
				j += 1
			} else {
				elementsEqual += 1
				i += 1
				j += 1
			}
		}

		return elementsEqual == count
	}
}
