import Foundation

public struct Match {
    public let matches: [String]
    
    public init(string: String, result: NSTextCheckingResult) {
        matches = (0..<result.numberOfRanges).map { index in
            (string as NSString).substring(with: result.range(at: index))
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
    
    public func matches(_ string: String) -> Bool {
        return matches(in: string)?.matches.first == string
    }
    
    public func matches(in string: String) -> Match? {
        guard let match = regularExpression.firstMatch(in: string, options: [.withTransparentBounds], range: NSMakeRange(0, string.utf16.count)) else {
            return nil
        }
        return Match(string: string, result: match)
    }
    
    public func allMatches(in string: String) -> [Match] {
        return regularExpression.matches(in: string, options: [], range: NSMakeRange(0, string.utf16.count))
            .map { Match(string: string, result: $0) }
    }
}
