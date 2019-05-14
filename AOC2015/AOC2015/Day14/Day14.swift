import Foundation
import AdventOfCode

public struct DeerInfo {
    public let name: String
    public let speed: Int
    public let duration: Int
    public let rest: Int
}

public enum DeerPhase {
    case flying(remaining: Int)
    case resting(remaining: Int)
}

public struct DeerState {
    public let info: DeerInfo
    public let phase: DeerPhase
    public let distance: Int
    
    public func tick() -> DeerState {
        switch phase {
        case .flying(remaining: let remainingSeconds) where remainingSeconds > 0:
            return DeerState(info: info, phase: .flying(remaining: remainingSeconds - 1), distance: distance + info.speed)
        case .resting(remaining: let remainingSeconds) where remainingSeconds > 0:
            return DeerState(info: info, phase: .resting(remaining: remainingSeconds - 1), distance: distance)
        case .flying:
            return DeerState(info: info, phase: .resting(remaining: info.rest - 1), distance: distance)
        case .resting:
            return DeerState(info: info, phase: .flying(remaining: info.duration - 1), distance: distance + info.speed)
        }
    }
}

public final class Day14: Day {
    private let seconds: Int
    private let deerStates: [DeerState]
    
    public init(seconds: Int = 2503, input: [String] = Input().trimmedInputCharactersByNewlines()) {
        self.seconds = seconds
        let regex = Regex(pattern: "^(\\w+) can fly (\\d+) km/s for (\\d+) seconds, but then must rest for (\\d+) seconds\\.$")
        
        deerStates = input.map { deerStatus in
            let matches = regex.matches(in: deerStatus)!
            let info = DeerInfo(name: matches[1], speed: Int(matches[2])!, duration: Int(matches[3])!, rest: Int(matches[4])!)
            return DeerState(info: info, phase: .flying(remaining: info.duration), distance: 0)
        }
        
        super.init()
    }
    
    public override func part1() -> String {
        let maxDistance = (0..<seconds)
            .reduce(deerStates) { states, _ in states.map({ $0.tick() }) }
            .map({ $0.distance })
            .max()!
        return String(maxDistance)
    }
    
    public override func part2() -> String {
        let maxPoints = (0..<seconds)
            .scan(deerStates) { states, _ in
                states.map({ $0.tick() })
            }
            .dropFirst()
            .reduce([]) { names, states in
                names + states
                    .filter { $0.distance == states.map({ $0.distance }).max() }
                    .map { $0.info.name }
            }
            .countElements().values.max()!
        return String(maxPoints)
    }
}
