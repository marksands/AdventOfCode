import Foundation
import AdventOfCode

public final class Day13: Day {
	private let departure: Int
	private let busIds: [String]

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		departure = Int(input[0])!
		busIds = input[1].components(separatedBy: ",")
		super.init()
	}

	public override func part1() -> String {
		let inServiceBuses = busIds.compactMap { Int($0) }

		let (minutes, earliestBus) = inServiceBuses
			.map { ($0 * ((departure / $0) + 1), $0) }
			.min(by: <)!

		return String(earliestBus * (minutes - departure))
	}

	// No, I do not understand any of this. (see: Chinese Remainder Theorem)
	public override func part2() -> String {
		let busIdsToDelays = busIds.enumerated().compactMap({ $1 == "x" ? nil : ($0, Int($1)!) })

		func mod_inverse(a: Int, m: Int) -> Int {
			let tmp = a % m
			for i in 1..<m {
				if (tmp * i % m == 1) {
					return i
				}
			}
			return 0
		}

		let busIdsMultiplied = busIds.product({ Int($0) ?? 1 })

		var total = 0

		for (i, busId) in busIdsToDelays {
			let multipleId = busIdsMultiplied / busId
			let inverseMod = mod_inverse(a: multipleId, m: busId)

			let offset = (busId - i % busId) % busId
			total += offset * inverseMod * multipleId
		}

		total = total % busIdsMultiplied

		return "\(total)"
	}
}
