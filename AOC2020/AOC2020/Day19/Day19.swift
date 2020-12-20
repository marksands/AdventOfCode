import Foundation
import AdventOfCode

public final class Day19: Day {
	private var input: String = ""

	public init(input: String = Input().trimmedRawInput()) {
		super.init()
		self.input = input
	}

	public override func part1() -> String {
		let groups = input.groups

		var rules: [String: String] = [:]

		for line in groups[0].lines {
			let parts = line.components(separatedBy: ": ")
			rules[parts[0]] = parts[1]
		}

		func matches(_ string: Substring, rule: String) -> [Substring] {
			guard !string.isEmpty else {
				return []
			}

			if rule == #""a""# {
				if string.hasPrefix("a") {
					return [string.dropFirst()]
				} else {
					return []
				}
			} else if rule == #""b""# {
				if string.hasPrefix("b") {
					return [string.dropFirst()]
				} else {
					return []
				}
			}

			let match = rules[rule]!

			let components = match.components(separatedBy: " ")

			if match.contains("|") {
				let ORd = match.components(separatedBy: " | ")
				let eachOr = ORd.map { $0.components(separatedBy: " ") }

				return eachOr.flatMap { or in
					or.reduce([string]) { a, nextRule -> [Substring] in
						a.flatMap { b in
							matches(b, rule: nextRule)
						}
					}
				}

			} else if components.count == 2 {
				return matches(string, rule: components[0]).flatMap { matches($0, rule: components[1]) }
			} else if components.count == 3 {
				return matches(string, rule: components[0])
					.flatMap {
						matches($0, rule: components[1]).flatMap { matches($0, rule: components[2]) }
					}
			} else {
				return matches(string, rule: match)
			}
		}

		let result = groups[1].lines.count(where: { matches($0[...], rule: "0").contains("") })

		return "\(result)"
	}

	public override func part2() -> String {
		let groups = input.groups

		var rules: [String: String] = [:]

		for line in groups[0].lines {
			let parts = line.components(separatedBy: ": ")
			rules[parts[0]] = parts[1]
		}

		rules["8"] = "42 | 42 8"
		rules["11"] = "42 31 | 42 11 31"

		func matches(_ string: Substring, rule: String) -> [Substring] {
			guard !string.isEmpty else {
				return []
			}

			if rule == #""a""# {
				if string.hasPrefix("a") {
					return [string.dropFirst()]
				} else {
					return []
				}
			} else if rule == #""b""# {
				if string.hasPrefix("b") {
					return [string.dropFirst()]
				} else {
					return []
				}
			}

			let match = rules[rule]!

			let components = match.components(separatedBy: " ")

			if match.contains("|") {
				let ORd = match.components(separatedBy: " | ")
				let eachOr = ORd.map { $0.components(separatedBy: " ") }

				return eachOr.flatMap { or in
					or.reduce([string]) { a, nextRule -> [Substring] in
						a.flatMap { b in
							matches(b, rule: nextRule)
						}
					}
				}
			} else if components.count == 2 {
				return matches(string, rule: components[0]).flatMap { matches($0, rule: components[1]) }
			} else if components.count == 3 {
				return matches(string, rule: components[0])
					.flatMap {
						matches($0, rule: components[1]).flatMap { matches($0, rule: components[2]) }
					}
			} else {
				return matches(string, rule: match)
			}
		}

		let result = groups[1].lines.count(where: { matches($0[...], rule: "0").contains("") })

		return "\(result)"
	}
}
