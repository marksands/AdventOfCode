import Foundation

public final class Day5: Day {
    private let input = Input().trimmedRawInput()
        
    public override func part1() -> String {
        return "\(removingAdjacentOpposingPolarities(from: input).count)"
    }
    
    public override func part2() -> String  {
        let result = zip(lowercaseLetters, uppercaseLetters)
            .map({ input.stripping($0).stripping($1) })
            .map { removingAdjacentOpposingPolarities(from: $0).count }
            .min()!
        return String(result)
    }
    
    public func removingAdjacentOpposingPolarities(from value: String) -> String {
        return value.reduce(into: "") { (current, next) in
            if let cur = current.last, next != cur && String(next).lowercased() == String(cur).lowercased() {
                current.removeLast()
            } else {
                current += String(next)
            }
        }
    }
}
