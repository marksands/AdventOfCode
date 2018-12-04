import UIKit
import AOC2018

let input = """
[1518-11-01 00:30] falls asleep
[1518-11-01 00:05] falls asleep
[1518-11-01 23:58] Guard #99 begins shift
[1518-11-01 00:00] Guard #10 begins shift
[1518-11-01 00:25] wakes up
[1518-11-01 00:55] wakes up
[1518-11-03 00:24] falls asleep
[1518-11-02 00:40] falls asleep
[1518-11-02 00:50] wakes up
[1518-11-03 00:05] Guard #10 begins shift
[1518-11-04 00:02] Guard #99 begins shift
[1518-11-03 00:29] wakes up
[1518-11-04 00:36] falls asleep
[1518-11-04 00:46] wakes up
[1518-11-05 00:03] Guard #99 begins shift
[1518-11-05 00:45] falls asleep
[1518-11-05 00:55] wakes up
"""

let df = DateFormatter()
df.dateFormat = "y-MM-dd HH:mm"
df.timeZone = TimeZone(secondsFromGMT: 0)
df.date(from: "1518-11-01 00:00")

struct Shift2: Equatable, Hashable, CustomDebugStringConvertible {
    let start: Date
    let end: Date
    
    var minuteRanges: [String] {
        df.dateFormat = "mm"
        var result: [String] = []
        var date = start
        while date < end {
            result.append(df.string(from: date))
            date = Calendar.current.date(byAdding: .minute, value: 1, to: date)!
        }
        return result
    }
    
    var debugDescription: String {
        return "\(start) -> \(end)\n"
    }
}

struct Shift: Equatable, Hashable, CustomDebugStringConvertible {
    let start: Int
    let end: Int
    
    var minuteRanges: [Int] {
        return Array(start..<end)
    }
    
    var debugDescription: String {
        return "\(minuteRanges)\n"
    }
}


struct Input {
    let date: Date
    let minutes: Int
    let action: String
}

let guardIdRegex = Regex(pattern: "Guard #(\\d+) begins shift")
let dateRegex = Regex(pattern: "^\\[(\\d{4}-\\d{2}-\\d{2}) (\\d+):(\\d+)\\]")

let sanitizedInput = input.components(separatedBy: .newlines).compactMap { row -> Input? in
    guard let match = dateRegex.matches(in: row),
        let date = df.date(from: match[1] + " \(match[2]):\(match[3])"),
        let action = row.components(separatedBy: match.matches[0]).last?.trimmingCharacters(in: .whitespaces),
        let minutes = match.matches.last.flatMap(Int.init) else {
            return nil
    }
    return Input(date: date, minutes: minutes, action: action)
}.sorted(by: { $0.date < $1.date })


var guardShifts: [String: [Shift]] = [:]

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

// part 1
let guardId = guardShifts.max(by: { $0.value.flatMap { $0.minuteRanges }.count < $1.value.flatMap { $0.minuteRanges }.count })!.key
let frequentMinute = guardShifts[guardId].map { $0.flatMap { $0.minuteRanges } }!.sorted { $0 > $1 }.first!
guardId
frequentMinute
Int(guardId)! * frequentMinute

// part 2
let guardId2 = guardShifts.max { (arg1, arg2) in
    arg1.value.flatMap { $0.minuteRanges }.countElements().sorted { $0.value > $1.value }.first!.value <
    arg2.value.flatMap { $0.minuteRanges }.countElements().sorted { $0.value > $1.value }.first!.value
}!.key
let frequentMinute2 = guardShifts[guardId2]!.flatMap { $0.minuteRanges }.countElements().sorted { $0.value > $1.value }.first!.key

Int(guardId2)! * frequentMinute2
