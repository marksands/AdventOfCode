import Foundation
import AdventOfCode

public final class Day11: Day {
    class Monkey {
        let index: Int
        var startingItems: [Int]
        let divisibleTest: Int
        let trueCondition: Int
        let falseCondition: Int
        let operation: (Int) -> Int

        var inspectionCount = 0

        init(index: Int, startingItems: [Int], divisibleTest: Int, trueCondition: Int, falseCondition: Int, operation: @escaping (Int) -> Int) {
            self.index = index
            self.startingItems = startingItems
            self.divisibleTest = divisibleTest
            self.trueCondition = trueCondition
            self.falseCondition = falseCondition
            self.operation = operation
        }

        func nextMonkeyIndex(for worryLevel: Int) -> Int {
            if worryLevel.isMultiple(of: divisibleTest) {
                return trueCondition
            } else {
                return falseCondition
            }
        }
    }

    private var monkeys: [Monkey] = []

    public init(rawInput: String = Input().trimmedRawInput()) {
        super.init()
        for group in rawInput.groups {
            let monkeyIndex = group.lines[0].int
            let startingItems = group.lines[1].ints
            let divisible = group.lines[3].int
            let trueCondition = group.lines[4].int
            let falseCondition = group.lines[5].int
            let operation: (Int) -> Int
            let opLine = group.lines[2].components(separatedBy: " = old ").last!
            if opLine.hasPrefix("*"), let num = opLine.ints.last {
                operation = { $0 * num }
            } else if opLine.hasPrefix("+"), let num = opLine.ints.last {
                operation = { $0 + num }
            } else {
                operation = { $0 * $0 }
            }
            let monkey = Monkey(
                index: monkeyIndex,
                startingItems: startingItems,
                divisibleTest: divisible,
                trueCondition: trueCondition,
                falseCondition: falseCondition,
                operation: operation
            )
            monkeys.append(monkey)
        }
    }

    public override func part1() -> String {
        for _ in (0..<20) {
            for monkey in monkeys {
                for worryableItem in monkey.startingItems {
                    var newLevel = monkey.operation(worryableItem)
                    newLevel = newLevel / 3
                    let nextMonkeyIdx = monkey.nextMonkeyIndex(for: newLevel)
                    let nextMonkey = monkeys.first(where: { $0.index == nextMonkeyIdx })!
                    nextMonkey.startingItems.append(newLevel)
                }
                monkey.inspectionCount += monkey.startingItems.count
                monkey.startingItems.removeAll()
            }
        }

        return monkeys
            .sorted(by: { $0.inspectionCount > $1.inspectionCount })[0..<2]
            .map { $0.inspectionCount }
            .product()
            .string
    }

    public override func part2() -> String {
        let lcm = AdventOfCode.lcm(monkeys.map { $0.divisibleTest })

        for _ in (0..<10_000) {
            for monkey in monkeys {
                for worryableItem in monkey.startingItems {
                    let newLevel = monkey.operation(worryableItem) % lcm
                    let nextMonkeyIdx = monkey.nextMonkeyIndex(for: newLevel)
                    let nextMonkey = monkeys.first(where: { $0.index == nextMonkeyIdx })!
                    nextMonkey.startingItems.append(newLevel)
                }
                monkey.inspectionCount += monkey.startingItems.count
                monkey.startingItems.removeAll()
            }
        }

        return monkeys
            .sorted(by: { $0.inspectionCount > $1.inspectionCount })[0..<2]
            .map { $0.inspectionCount }
            .product()
            .string
    }
}
