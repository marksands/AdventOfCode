import Foundation

public struct Match {
    public let matches: [String]
    
    public init(string: String, result: NSTextCheckingResult) {
        matches = (0..<result.numberOfRanges).compactMap { index in
            let range = result.range(at: index)
            guard range.location != NSNotFound else { return nil }
            return (string as NSString).substring(with: range)
        }
    }
    
    public subscript(index: Int) -> String {
        return matches[index]
    }
}

public final class Regex {
    private let regularExpression: NSRegularExpression
    
    public init(pattern: String) {
        do {
            regularExpression = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            fatalError("Failed to instantiate Regex \(pattern). Reason: \(error)")
        }
    }
    
    public func matches(in string: String) -> Match? {
        guard let match = regularExpression.firstMatch(in: string, options: [.withTransparentBounds], range: NSMakeRange(0, string.utf16.count)) else {
            return nil
        }
        return Match(string: string, result: match)
    }
    
    public func matches(_ string: String) -> Bool {
        return matches(in: string)?.matches.first == string
    }
    
    public func allMatches(_ string: String) -> [Match] {
        var result: [Match] = []
        regularExpression.enumerateMatches(in: string, options: [.withTransparentBounds], range: NSMakeRange(0, string.utf16.count), using: { textCheckingResult, matchingFlags, stop in
            if let textCheckingResult = textCheckingResult {
                result.append(Match(string: string, result: textCheckingResult))
            }
        })
        return result
    }
}

public func ~= (left: Regex, right: String) -> Bool {
    return left.matches(right)
}
