import XCTest
import AOC2018

class CircularListTests: XCTestCase {
    func testCanCreateNewList() {
        let testObject = CircularList(value: 0)
        XCTAssertEqual(0, testObject.value)
    }
    
    func testCircularListAddsValue() {
        let testObject = CircularList(value: 0)
        let nextObject = testObject.insertAfter(1)
        
        XCTAssertEqual(0, testObject.value)
        XCTAssertEqual(1, nextObject.value)
        
        let valueTwo = testObject.insertAfter(2)
        let valueThree = valueTwo.insertAfter(3)
        
        XCTAssertEqual(0, testObject.value)
        XCTAssertEqual(1, nextObject.value)
        XCTAssertEqual(2, valueTwo.value)
        XCTAssertEqual(3, valueThree.value)
    }
    
    func testCircularListInsertsAfterNode() {
        let testObject = CircularList(value: 0).insertAfter(1).insertAfter(2).insertAfter(3)
        XCTAssertEqual(3, testObject.value)
    }
    
    func testCircularListAddsValueInMiddleOfList() {
        let testObject = CircularList(value: 0)
        let valueOne = testObject.insertAfter(1)
        let valueThree = valueOne.insertAfter(3)
        
        XCTAssertEqual(0, testObject.value)
        XCTAssertEqual(1, valueOne.value)
        XCTAssertEqual(3, valueThree.value)

        let valueTwo = valueOne.insertAfter(2)
        
        
        XCTAssertEqual(0, testObject.value)
        XCTAssertEqual(1, valueOne.value)
        XCTAssertEqual(2, valueTwo.value)
        XCTAssertEqual(3, valueThree.value)
    }

    func testCircularListRemovesValue() {
        let testObject = CircularList(value: 0)
        let valueOne = testObject.insertAfter(1)
        valueOne.insertAfter(2)
        
        let (expectZero, expectTwo) = valueOne.remove()

        XCTAssertEqual(0, expectZero.value)
        XCTAssertEqual(2, expectTwo.value)
        
        let (expectZeroAgain, expectZeroCirclularly) = expectTwo.remove()

        XCTAssertEqual(0, expectZeroAgain.value)
        XCTAssertEqual(0, expectZeroCirclularly.value)
    }
    
    func testCircularListRemoveReturnsLeftAndRightNode() {
        let testObject = CircularList(value: 0)
        let toRemove = testObject.insertAfter(1)
        toRemove.insertAfter(2)

        let (left, right) = toRemove.remove()
        
        XCTAssertEqual(0, left.value)
        XCTAssertEqual(2, right.value)
    }

    func testCircularListInsertsBeforeNode() {
        let testObject = CircularList(value: 0)
        let valueOne = testObject.insertBefore(3).insertBefore(2).insertBefore(1)
        
        XCTAssertEqual(0, testObject.value)
        XCTAssertEqual(1, valueOne.value)
    }
    
    func testCircularListAdvances() {
        var testObject = CircularList(value: 0)
        testObject.insertAfter(1).insertAfter(2).insertAfter(3).insertAfter(4)

        XCTAssertEqual(0, testObject.value)
        
        testObject = testObject.advance(by: 1)
        XCTAssertEqual(1, testObject.value)
        
        testObject = testObject.advance(by: 2)
        XCTAssertEqual(3, testObject.value)

        testObject = testObject.advance(by: 2)
        XCTAssertEqual(0, testObject.value)
    }
    
    func testCircularListReverses() {
        var testObject = CircularList(value: 0)
        testObject.insertAfter(1).insertAfter(2).insertAfter(3).insertAfter(4)
        
        XCTAssertEqual(0, testObject.value)
        
        testObject = testObject.reverse(by: 1)
        XCTAssertEqual(4, testObject.value)
        
        testObject = testObject.reverse(by: 2)
        XCTAssertEqual(2, testObject.value)
        
        testObject = testObject.reverse(by: 2)
        XCTAssertEqual(0, testObject.value)
    }
}
