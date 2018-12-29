import Foundation

public final class Day14: Day {
    private let input = 765071

    public override func part1() -> String {
        let list = CircularList(value: 3)
        let root = list
        
        list.insertAfter(7)
        
        var recipe1Node = root
        var recipe2Node = root.advance(by: 1)
        
        var step = 0
        while step < (input + 10) {
            let sumOfRecipe = recipe1Node.value + recipe2Node.value
            
            if sumOfRecipe >= 10 {
                root.insertBefore(1)
                step += 1
            }

            root.insertBefore(sumOfRecipe % 10)
            step += 1
            
            recipe1Node = recipe1Node.advance(by: recipe1Node.value + 1)
            recipe2Node = recipe2Node.advance(by: recipe2Node.value + 1)
        }
        
        return (input..<(input + 10)).reduce([]) { $0 + [root.advance(by: $1).value] }.map { String($0) }.joined()
    }
    
    public override func part2() -> String {
        var values: [Int] = [3, 7]
        let expectedResult = String(input).exploded().compactMap(Int.init)

        var recipe1Index = 0
        var recipe2Index = 1
        
        var step = 2
        while true {
            let recipe1Score = values[recipe1Index]
            let recipe2Score = values[recipe2Index]
            let sumOfRecipe = recipe1Score + recipe2Score
            
            if sumOfRecipe >= 10 {
                values.append(1)
                step += 1
                
                if values.count > expectedResult.count, Array(values.suffix(from: values.count - expectedResult.count)) == expectedResult {
                    return "\(step - expectedResult.count)"
                }
            }
            
            values.append(sumOfRecipe % 10)
            step += 1
            
            if values.count > expectedResult.count, Array(values.suffix(from: values.count - expectedResult.count)) == expectedResult {
                return "\(step - expectedResult.count)"
            }
            
            recipe1Index = (recipe1Index + recipe1Score + 1) % values.count
            recipe2Index = (recipe2Index + recipe2Score + 1) % values.count
        }
    }
}
