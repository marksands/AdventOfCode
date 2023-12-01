import Foundation
import AdventOfCode

public enum NestedValue: Codable, Equatable, Comparable {
    indirect case nested([NestedValue])
    case int(Int)

    public init(from decoder: Decoder) throws {
        if let int = try? Int.init(from: decoder) {
            self = .int(int)
        } else {
            var container = try decoder.unkeyedContainer()
            var result: [NestedValue] = []
            while !container.isAtEnd {
                let nested = try! container.decode(NestedValue.self)
                result.append(nested)
            }
            self = .nested(result)
        }
    }

    public static func <(lhs: NestedValue, rhs: NestedValue) -> Bool {
        switch (lhs, rhs) {
        case (.nested(let l), .nested(let r)):
            return l.lexicographicallyPrecedes(r)
        case (.int, .nested):
            return .nested([lhs]) < rhs
        case (.nested, .int):
            return lhs < .nested([rhs])
        case (.int(let l), .int(let r)):
            return l < r
        }
    }
}

public final class Day13: Day {
    private let rawInput: String

    public init(rawInput: String = Input().trimmedRawInput()) {
        self.rawInput = rawInput
        super.init()
    }

    public override func part1() -> String {
        return rawInput.groups
            .map { [serializedPair(from: $0.lines[0]), serializedPair(from: $0.lines[1])] }
            .enumerated()
            .filter { $1[0] < $1[1] }
            .map { $0.0 + 1 }
            .sum()
            .string
    }

    public override func part2() -> String {
        let divider1 = NestedValue.nested([.nested([.int(2)])])
        let divider2 = NestedValue.nested([.nested([.int(6)])])
        return (rawInput.groups
            .flatMap {
                [serializedPair(from: $0.lines[0]), serializedPair(from: $0.lines[1])]
            } + [divider1, divider2])
            .sorted(by: <).enumerated()
            .filter { _, p in [divider1, divider2].contains(p) }
            .map { $0.offset + 1}
            .product()
            .string
    }

    private func serializedPair(from v: String) -> NestedValue {
        return try! JSONDecoder().decode(NestedValue.self, from: v.data(using: .utf8)!)
    }
}
