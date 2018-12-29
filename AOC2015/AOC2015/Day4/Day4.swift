import Foundation
import AdventOfCode
import CommonCrypto

public final class Day4: Day {
    private let seed = "ckczppom"

    public override func part1() -> String {
        return String(firstNumberMatchingHash(0xffff_f000_0000_0000))
    }
    
    public override func part2() -> String {
        return String(firstNumberMatchingHash(0xffff_ff00_0000_0000))
    }
    
    private func firstNumberMatchingHash(_ match: UInt64) -> Int {
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_MD5_DIGEST_LENGTH))
        defer { result.deallocate() }
        
        for number in (1...) {
            let value = (seed + String(number))
            CC_MD5(value, CC_LONG(value.count), result)
            if result.withMemoryRebound(to: UInt64.self, capacity: 16, { $0.pointee.bigEndian & match == 0 }) {
                return number
            }
        }
        fatalError()
    }
}
