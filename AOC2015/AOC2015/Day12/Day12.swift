import Foundation
import AdventOfCode

public final class Day12: Day {
    private let json = try! JSONSerialization.jsonObject(with: Input().trimmedRawInput().data(using: .utf8)!, options: [])

    public override func part1() -> String {
        return String(sumOfObjects(json, stopIf: { _ in false }))
    }
    
    public override func part2() -> String {
        return String(sumOfObjects(json, stopIf: { value in value.contains(where: { ($0 as? String) == "red" }) }))
    }
    
    private func sumOfObjects(_ object: Any, stopIf: ([Any]) -> Bool) -> Int {
        if let value = object as? Int {
            return value
        } else if let array = object as? [Any] {
            return array.reduce(into: 0) { $0 += sumOfObjects($1, stopIf: stopIf) }
        } else if let dictionary = object as? [String: Any], !stopIf(dictionary.values.map { $0 }) {
            return dictionary.values.reduce(into: 0) { $0 += sumOfObjects($1, stopIf: stopIf) }
        } else {
            return 0
        }
    }
}
