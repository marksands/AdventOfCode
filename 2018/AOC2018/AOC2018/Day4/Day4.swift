import Foundation

struct InputHelper {
    let date: Date
    let minutes: Int
    let action: String
}

struct Shift: Equatable, Hashable {
    let start: Int
    let end: Int
    
    var minuteRanges: [Int] {
        return Array(start..<end)
    }
}

public final class Day4: Day {
    var guardShifts: [String: [Shift]] = [:]

    public override init() {
        super.init()

        let df = DateFormatter()
        df.dateFormat = "y-MM-dd HH:mm"
        df.timeZone = TimeZone(secondsFromGMT: 0)
        df.date(from: "1518-11-01 00:00")

        let guardIdRegex = Regex(pattern: "Guard #(\\d+) begins shift")
        let dateRegex = Regex(pattern: "^\\[(\\d{4}-\\d{2}-\\d{2}) (\\d+):(\\d+)\\]")
        
        let sanitizedInput = Input().trimmedInputCharactersByNewlines().compactMap { row -> InputHelper? in
            guard let match = dateRegex.matches(in: row),
                let date = df.date(from: match[1] + " \(match[2]):\(match[3])"),
                let action = row.components(separatedBy: match.matches[0]).last?.trimmingCharacters(in: .whitespaces),
                let minutes = match.matches.last.flatMap(Int.init) else {
                    return nil
            }
            return InputHelper(date: date, minutes: minutes, action: action)
        }.sorted(by: { $0.date < $1.date })
        
        var minuteSleeping: Int?
        var currentId: String?
        var currentShift: Shift?
        
        sanitizedInput.forEach { input in
            if input.action.starts(with: "falls asleep") {
                minuteSleeping = input.minutes
            } else if input.action.starts(with: "wakes up") {
                currentShift = Shift(start: minuteSleeping!, end: input.minutes)
                minuteSleeping = nil
            } else if let match = guardIdRegex.matches(in: input.action) {
                currentId = match.matches[1]
                minuteSleeping = nil
            }
            if let id = currentId, let shift = currentShift {
                guardShifts[id, default: []].append(shift)
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
        return guardShifts[id]?.flatMap({ $0.minuteRanges }).countElements().sorted(by: { $0.value > $1.value }).first?.key
    }

    private func durationOfNaps(for shifts: [Shift]) -> Int {
        return shifts.flatMap { $0.minuteRanges }.count
    }

    private func mostFrequentMinute(within shifts: [Shift]) -> Int {
        return shifts.flatMap { $0.minuteRanges }.countElements().sorted { $0.value > $1.value }.first!.value
    }
    
    private func sleepiestGuardId() -> String? {
        return guardShifts.max(by: { durationOfNaps(for: $0.value) < durationOfNaps(for: $1.value) })?.key
    }
    
    private func mostPredictableNappingGuardId() -> String? {
        return guardShifts.max(by: { mostFrequentMinute(within: $0.value) < mostFrequentMinute(within: $1.value) })?.key
    }
}
