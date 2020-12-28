import XCTest

class CollectionIntersectionTests: XCTestCase {
	func testIntersection() {
		XCTAssertTrue(["a", "b", "c"].isContainedWithin(["a", "A", "b", "B", "c"]))

		let set: Set<String> = ["a", "A", "b", "B", "c"]
		XCTAssertTrue(["a", "b", "c"].isContainedWithin(set))

		let dict = ["a": true, "b": true]
		XCTAssertTrue(dict.keys.isContainedWithin(set))

		XCTAssertTrue(["a", "b", "c"].isContainedWithin(["A", "a", "B", "b", "c", "C"]))

		XCTAssertTrue(["a"].isContainedWithin(["A", "a"]))

		XCTAssertFalse(["a", "A", "b"].isContainedWithin(["a", "b"]))

		XCTAssertFalse(["A", "A", "B", "B"].isContainedWithin(set))

		XCTAssertFalse(set.isContainedWithin(["A", "A", "B", "B"]))

		XCTAssertFalse(["a", "b", "c"].isContainedWithin(["A", "B", "C"]))

		XCTAssertFalse(["a"].isContainedWithin(["A"]))

		XCTAssertFalse(["A"].isContainedWithin(["a"]))

		XCTAssertFalse(Array<String>().isContainedWithin(Array<String>()))

		XCTAssertFalse(Array<String>().isContainedWithin(["a"]))

		XCTAssertFalse(["a"].isContainedWithin(Array<String>()))
	}

	func testFailureCaseFromAOC2019Day18() {
		let allKeys = ["h", "f", "w", "g", "d", "j", "u", "v", "q", "z", "r", "o", "n", "m", "k", "e", "i", "x", "t", "p", "b", "a", "l", "s", "c", "y"]
		let keyring = Set(["u", "y", "L", "n", "g", "v", "b", "Q", "Y", "o", "U", "x", "V", "W", "h", "B", "l", "E", ".", "a", "w", "Z", "X", "d", "z", "G", "C", "q", "e", "D", "c"])
		XCTAssertFalse(allKeys.isContainedWithin(keyring))
	}
}
