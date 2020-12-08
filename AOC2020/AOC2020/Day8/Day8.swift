import Foundation
import AdventOfCode

public final class Day8: Day {

	enum Operation: Hashable {
		case acc(Int, Int)
		case jmp(Int, Int)
		case nop(Int, Int)

		init(_ instr: String, _ cnt: Int, _ id: Int) {
			if instr == "acc" {
				self = .acc(cnt, id)
			} else if instr == "jmp" {
				self = .jmp(cnt, id)
			} else {
				self = .nop(cnt, id)
			}
		}

		func hash(into hasher: inout Hasher) {
			switch self {
			case .acc(_, let id):
				hasher.combine(id)
			case .jmp(_, let id):
				hasher.combine(id)
			case .nop(_, let id):
				hasher.combine(id)
			}
		}

		func swapped() -> Operation {
			switch self {
			case .nop(let count, let id):
				return .jmp(count, id)
			case .jmp(let count, let id):
				return .nop(count, id)
			default:
				fatalError()
			}
		}

		var isNopOrJmp: Bool {
			switch self {
			case .acc: return false
			case .jmp: return true
			case .nop: return true
			}
		}
	}

	private var input: [String] = []

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		super.init()
		self.input = input
	}

	public override func part1() -> String {

		var ops: [Operation] = []

		for (offset, line) in input.enumerated() {
			let components = line.components(separatedBy: " ")
			let instruction = components[0]
			let int = Parser.int.run(components[1][...]).match!
			let op = Operation(instruction, int, offset)
			ops.append(op)
		}

		var visited = Set<Operation>()

		var accumulator = 0
		var pc = 0

		while true {
			let op = ops[pc]

			if !visited.insert(op).inserted {
				return String(accumulator)
			}

			switch op {
			case .acc(let value, _):
				accumulator += value
				pc += 1
			case .jmp(let value, _):
				pc += value
			case .nop:
				pc += 1
			}
		}

		fatalError()
	}

	public override func part2() -> String {

		var ops: [Operation] = []

		for (offset, line) in input.enumerated() {
			let components = line.components(separatedBy: " ")
			let instruction = components[0]
			let int = Parser.int.run(components[1][...]).match!
			let op = Operation(instruction, int, offset)
			ops.append(op)
		}

		let originalOps = ops

		var firstIndexOfNopOrJmp = 0

		for _ in (0...ops.count) {

			ops = originalOps

			while firstIndexOfNopOrJmp < ops.count {
				firstIndexOfNopOrJmp += 1
				if ops[firstIndexOfNopOrJmp].isNopOrJmp {
					break
				}
			}

			var accumulator = 0
			var pc = 0

			ops[firstIndexOfNopOrJmp] = ops[firstIndexOfNopOrJmp].swapped()

			for _ in (0...10_000) {
				if pc >= ops.count {
					return String(accumulator)
				}

				let op = ops[pc]

				switch op {
				case .acc(let value, _):
					accumulator += value
					pc += 1
				case .jmp(let value, _):
					pc += value
				case .nop:
					pc += 1
				}
			}
		}

		fatalError()
	}
}
