import Foundation

public final class Day9: Day {
    private let players: Int
    private let lastPoints: Int
    
    public init(input: String = Input().trimmedRawInput()) {
        let regex = Regex(pattern: "^(\\d{3}) players; last marble is worth (\\d{5}) points$")
        let matches = regex.matches(in: input)!
        players = Int(matches[1])!
        lastPoints = Int(matches[2])!
        super.init()
    }
    
    public override func part1() -> String {
        return String(highestPlayerScore(maxPoints: lastPoints))
    }
    
    public override func part2() -> String {
        return String(highestPlayerScore(maxPoints: lastPoints * 100))
    }
    
    private func highestPlayerScore(maxPoints: Int) -> Int {
        var playerScores: [Int: Int] = [:]
        var list = CircularList(value: 0)
        
        (1...maxPoints).forEach { marble in
            if marble % 23 == 0 {
                list = list.reverse(by: 7)
                let score = list.value + marble
                (_, list) = list.remove()
                
                playerScores[marble % players, default: 0] += score
            } else {
                list = list.advance(by: 1).insertAfter(marble)
            }
        }
        
        return playerScores.values.max()!
    }
}
