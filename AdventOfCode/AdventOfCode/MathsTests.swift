import XCTest
import AdventOfCode

class MathsTests: XCTestCase {
    func testLCM() {
        XCTAssertEqual(lcm(10, 8), 40)
        XCTAssertEqual(lcm([180, 120, 140, 260]), 32760)
    }
    
    func testGCD() {
        XCTAssertEqual(gcd(52, 39), 13)
        XCTAssertEqual(gcd(228, 36), 12)
        XCTAssertEqual(gcd(51357, 3819), 57)
        XCTAssertEqual(gcd([180, 120, 140, 260]), 20)
    }
}
