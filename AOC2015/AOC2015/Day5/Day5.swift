import Foundation
import AdventOfCode

public final class Day5: Day {
    private let input = Input().trimmedInputCharactersByNewlines()
    
    public override func part1() -> String {
        return String(input.reduce(into: 0, {$0 += (isNicePart1($1) ? 1 : 0) }))
    }
    
    public override func part2() -> String {
        return String(input.reduce(into: 0, {$0 += (isNicePart2($1) ? 1 : 0) }))
    }
    
    private func isNicePart1(_ value: String) -> Bool {
        let hasVowels = value.exploded().count(where: { vowels.contains($0) }) >= 3
        let hasDoubleLetters = zip(value, value.dropFirst()).first(where: { a, b in a == b }) != nil
        let hasNoNaughtySequences =
            value.exploded().chunks(ofSize: 2).map { $0.joined() }.count(where: { ["ab", "cd", "pq", "xy"].contains($0) }) == 0 &&
            value.exploded().dropFirst().chunks(ofSize: 2).map { $0.joined() }.count(where: { ["ab", "cd", "pq", "xy"].contains($0) }) == 0
        return hasVowels && hasDoubleLetters && hasNoNaughtySequences
    }

    private func isNicePart2(_ value: String) -> Bool {
        var hasDuplicates = false
        for chunk in value.exploded().chunks(ofSize: 2) {
            if value.indicesOf(string: chunk.joined()).count > 1 {
                hasDuplicates = true
            }
        }
        for chunk in value.exploded().dropFirst().chunks(ofSize: 2).filter({ $0.count == 2 }) {
            if value.indicesOf(string: chunk.joined()).count > 1 {
                hasDuplicates = true
            }
        }

        let chunks = (value.exploded().chunks(ofSize: 2).map { $0.joined() } + value.exploded().dropFirst().chunks(ofSize: 2).map { $0.joined() }.filter { $0.count == 2 })
        let hasOverlaps = zip(value, value.dropFirst(2)).first(where: { a, b in a == b }) != nil
        return hasDuplicates && hasOverlaps
    }
}

extension String {
    func indicesOf(string: String) -> [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex

        while searchStartIndex < self.endIndex, let range = self.range(of: string, range: searchStartIndex..<self.endIndex), !range.isEmpty {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }

        return indices
    }
}
