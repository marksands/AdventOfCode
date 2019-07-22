import XCTest
import AdventOfCode

class IntegerPartitionSumTests: XCTestCase {
    func testIntegerPartition() {
        IntegerPartitionSum(sum: 10).forEach { partition in
            print(partition)
        }
        print("done!")
    }
}
