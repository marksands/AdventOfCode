import XCTest
import AOC2021

class AOC2021_Day18_Tests: XCTestCase {
	let day = Day18()

	func testPart1() {
		XCTAssertEqual("4207", day.part1())
	}

	func testPart2() {
		XCTAssertEqual("4635", day.part2())
	}
	
	func testAddSnailfishPair() {
		let actual = day.addSnailfishToFormAPair("[1,2]", "[[3,4],5]")
		let expected = "[[1,2],[[3,4],5]]"
		XCTAssertEqual(actual, expected)
	}
	
	func test1() {
		let someString = "[[[[[9,8],1],2],3],4]"
		let (si, ei) = day.maybeExplodingIndices(someString)!
		XCTAssertEqual(si, 5)
		XCTAssertEqual(ei, 7)

		let str2 = "[[[[[10,2002],1],2],3],4]"
		let (si1, ei2) = day.maybeExplodingIndices(str2)!
		XCTAssertEqual(si1, 5)
		XCTAssertEqual(ei2, 11)
	}
	
	func testExplode() {
		let someString = "[[[[[9,8],1],2],3],4]"
		let pairs = day.explodingPairAtIndex(someString, day.maybeExplodingIndices(someString)!)
		XCTAssertEqual(pairs.0, 9)
		XCTAssertEqual(pairs.1, 8)
		
		let str2 = "[[[[[10,2002],1],2],3],4]"
		let (si1, ei2) = day.explodingPairAtIndex(str2, day.maybeExplodingIndices(str2)!)
		XCTAssertEqual(si1, 10)
		XCTAssertEqual(ei2, 2002)
	}
	
	
	func testExplode2() {
		let someString = "[[[[[9,8],1],2],3],4]"
		
		let index = day.maybeExplodingIndices(someString)!
		let pairs = day.explodingPairAtIndex(someString, index)
		
		let result = day.explode(someString, index: index, pair: pairs)
		XCTAssertEqual(result, "[[[[0,9],2],3],4]")
		
		let str2 = "[7,[6,[5,[4,[3,2]]]]]"
		let i2 = day.maybeExplodingIndices(str2)!
		let p2 = day.explodingPairAtIndex(str2, i2)
		let r2 = day.explode(str2, index: i2, pair: p2)
		XCTAssertEqual(r2, "[7,[6,[5,[7,0]]]]")

		let str3 = "[[6,[5,[4,[3,2]]]],1]"
		let i3 = day.maybeExplodingIndices(str3)!
		let p3 = day.explodingPairAtIndex(str3, i3)
		let r3 = day.explode(str3, index: i3, pair: p3)
		XCTAssertEqual(r3, "[[6,[5,[7,0]]],3]")
		
		let str4 = "[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]"
		let i4 = day.maybeExplodingIndices(str4)!
		let p4 = day.explodingPairAtIndex(str4, i4)
		let r4 = day.explode(str4, index: i4, pair: p4)
		XCTAssertEqual(r4, "[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]")
		
		let str5 = "[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]"
		let i5 = day.maybeExplodingIndices(str5)!
		let p5 = day.explodingPairAtIndex(str5, i5)
		let r5 = day.explode(str5, index: i5, pair: p5)
		XCTAssertEqual(r5, "[[3,[2,[8,0]]],[9,[5,[7,0]]]]")

	}
	
	func testHard() {
		let str = "[[[[4,0],[5,4]],[[7,0],[15,5]]],[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]]"
		let i5 = day.maybeExplodingIndices(str)!
		let p5 = day.explodingPairAtIndex(str, i5)
		let r5 = day.explode(str, index: i5, pair: p5)
		XCTAssertEqual(r5, "[[[[4,0],[5,4]],[[7,0],[15,5]]],[10,[[0,[11,3]],[[6,3],[8,8]]]]]")
	}
	
	func testHard2() {
		let str = "[[[[5,9],[16,0]],[[10,[1,2]],[[1,4],2]]],[[[5,[2,8]],4],[5,[[9,9],0]]]]"
		let i5 = day.maybeExplodingIndices(str)!
		let p5 = day.explodingPairAtIndex(str, i5)
		let r5 = day.explode(str, index: i5, pair: p5)
		XCTAssertEqual(r5, "[[[[5,9],[16,0]],[[11,0],[[3,4],2]]],[[[5,[2,8]],4],[5,[[9,9],0]]]]")
	}
	
	func testSplit() {
		let st1 = "[[[[0,7],4],[15,[0,13]]],[1,1]]"
		let m1 = day.hasSplittingCriteria(st1)!
		let r1 = day.split(st1, matching: m1)
		XCTAssertEqual(r1, "[[[[0,7],4],[[7,8],[0,13]]],[1,1]]")
		
		let st2 = "[[[[0,7],4],[[7,8],[0,13]]],[1,1]]"
		let m2 = day.hasSplittingCriteria(st2)!
		let r2 = day.split(st2, matching: m2)
		XCTAssertEqual(r2, "[[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]")
	}
	
	func testMagnitude() {
		let result = day.magnitude("[[1,2],[2,3]]")
		XCTAssertEqual(45, result)
		
		let r2 = day.magnitude("[[[[0,0],1],7],[[[0,4],[7,7]],[1,6]]]")
		XCTAssertEqual(684, r2)
	}
}
