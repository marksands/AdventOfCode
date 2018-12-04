import Foundation

public final class Day4: Day {
    var guardShifts: [String: [Int]] = [:]

    public override init() {
        super.init()

        let df = DateFormatter()
        df.dateFormat = "y-MM-dd HH:mm"
        df.timeZone = TimeZone(secondsFromGMT: 0)
        df.date(from: "1518-11-01 00:00")

        let guardIdRegex = Regex(pattern: "Guard #(\\d+) begins shift")
        let dateRegex = Regex(pattern: "^\\[(\\d{4}-\\d{2}-\\d{2}) (\\d+):(\\d+)\\]")
        
        let sanitizedInput = Input().trimmedInputCharactersByNewlines().compactMap { row -> (date: Date, minutes: Int, action: String)? in
            guard let match = dateRegex.matches(in: row),
                let date = df.date(from: match[1] + " \(match[2]):\(match[3])"),
                let action = row.components(separatedBy: match.matches[0]).last?.trimmingCharacters(in: .whitespaces),
                let minutes = match.matches.last.flatMap(Int.init) else {
                    return nil
            }
            return (date: date, minutes: minutes, action: action)
        }.sorted(by: { $0.date < $1.date })
        
        var minuteSleeping: Int?
        var currentId: String?
        var currentShift: [Int]?
        
        sanitizedInput.forEach { input in
            if input.action.starts(with: "falls asleep") {
                minuteSleeping = input.minutes
            } else if input.action.starts(with: "wakes up") {
                currentShift = Array(minuteSleeping!..<input.minutes)
                minuteSleeping = nil
            } else if let match = guardIdRegex.matches(in: input.action) {
                currentId = match.matches[1]
                minuteSleeping = nil
            }
            if let id = currentId, let shift = currentShift {
                guardShifts[id, default: []] += shift
                currentShift = nil
            }
        }
    }
    
    public override func part1() -> String {
        return "\(part1Result())"
    }
    
    public override func part2() -> String {
        return "\(part2Result())"
    }
    
    private func part1Result() -> Int {
        guard let guardId = sleepiestGuardId(), let id = Int(guardId),
            let napTime = mostFrequentNapTime(forGuardId: guardId) else {
            fatalError("Failed to find sleepiest guard and their most frequently occurring nap time!")
        }
        return id * napTime
    }
    
    private func part2Result() -> Int {
        guard let guardId = mostPredictableNappingGuardId(), let id = Int(guardId),
            let napTime = mostFrequentNapTime(forGuardId: guardId) else {
                fatalError("Failed to find sleepiest guard with the most frequently occurring nap time!")
        }
        return id * napTime
    }
    
    private func mostFrequentNapTime(forGuardId id: String) -> Int? {
        return countedNapsByFrequency(guardShifts[id] ?? []).minute
    }

    private func sleepiestGuardId() -> String? {
        return guardShifts.max(by: { $0.value.count < $1.value.count })?.key
    }
    
    private func mostPredictableNappingGuardId() -> String? {
        return guardShifts.max(by: { countedNapsByFrequency($0.value).count < countedNapsByFrequency($1.value).count })?.key
    }
    
    private func countedNapsByFrequency(_ minutes: [Int]) -> (minute: Int, count: Int) {
        return minutes.countElements().sorted { $0.value > $1.value }.first.map { (minute: $0.key, count: $0.value ) }!
    }
}
