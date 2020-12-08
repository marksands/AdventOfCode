import Foundation
import AdventOfCode

public final class Day8: Day {
	enum Operation: String {
		case acc
		case jmp
		case nop

		mutating func swap() -> Bool {
			switch self {
			case .nop:
				self = .jmp
				return true
			case .jmp:
				self = .nop
				return true
			default:
				return false
			}
		}
	}

	private var ops: [(Operation, incr: Int)] = []

	public init(input: [String] = Input().trimmedInputCharactersByNewlines()) {
		super.init()

		self.ops = input.compactMap {
			Parser.prefix(upTo: " ")
				.skip(" ")
				.take(Parser.int)
				.map { (Operation(rawValue: String($0))!, $1) }
				.match($0)
		}
	}

	public override func part1() -> String {
		return String(execute(program: ops).accumulator)
	}

	public override func part2() -> String {
		let (accumulator, _) = ops.indices
			.lazy
			.compactMap { index in
				self.execute(program: self.ops, predicate: { $0[index].0.swap() })
			}
			.first(where: { accumulator, context in
				context == .terminated
			})!

		return String(accumulator)
	}

	enum ProgramExecutionContext: Equatable {
		case terminated
		case infiniteLoop
	}

	private func execute(program: [(Operation, incr: Int)], predicate: (inout [(Operation, incr: Int)]) -> Bool) -> (accumulator: Int, context: ProgramExecutionContext)? {
		var program = program
		guard predicate(&program) else { return nil }

		return execute(program: program)
	}

	private func execute(program: [(Operation, incr: Int)]) -> (accumulator: Int, context: ProgramExecutionContext) {
		var visited = Set<Int>()
		var accumulator = 0
		var pc = 0

		while true {
			guard pc < program.count else {
				return (accumulator, ProgramExecutionContext.terminated)
			}
			guard visited.insert(pc).inserted else {
				return (accumulator, ProgramExecutionContext.infiniteLoop)
			}

			let op = program[pc]

			switch op.0 {
			case .acc:
				accumulator += op.incr
				pc += 1
			case .jmp:
				pc += op.incr
			case .nop:
				pc += 1
			}
		}

	}
}
