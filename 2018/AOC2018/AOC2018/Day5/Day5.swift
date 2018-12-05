import Foundation

public final class Day5: Day {
    private let input = Input().trimmedRawInput()
        
    public override func part1() -> String {
        return "\(removingAdjacentOpposingPolarities(from: input).count)"
    }
    
    public override func part2() -> String  {
        let result = zip(lowercaseLetters, uppercaseLetters)
            .map({ input.stripping($0).stripping($1) })
            .map { removingAdjacentOpposingPolarities(from: $0) }
            .min(by: { $0.count < $1.count }) ?? ""
        return String(result.count)
    }
    
    public func removingAdjacentOpposingPolarities(from value: String) -> String {
        var result = value.exploded()
        var index = 0
        while index < result.count {
            if result.count > (index + 1) {
                if index > 0 && isOppositePolarity(result[index-1], result[index]) {
                    result.remove(at: index-1)
                    result.remove(at: index-1)
                    index -= 1
                } else if isOppositePolarity(result[index], result[index+1]) {
                    result.remove(at: index+1)
                    result.remove(at: index)
                } else {
                    index += 1
                }
            } else if isOppositePolarity(result[index-1], result[index]) {
                result.remove(at: index-1)
                result.remove(at: index-1)
            } else {
                index += 1
            }
        }
        return result.joined()
    }
    
    private func isOppositePolarity(_ s1: String, _ s2: String) -> Bool {
        let s1set = CharacterSet(charactersIn: s1)
        let s2set = CharacterSet(charactersIn: s2)
        
        if (s1set.isSubset(of: .lowercaseLetters) && s2set.isSubset(of: .uppercaseLetters)) ||
            (s2set.isSubset(of: .lowercaseLetters) && s1set.isSubset(of: .uppercaseLetters)) {
            return s1.lowercased() == s2.lowercased()
        }
        return false
    }
}
