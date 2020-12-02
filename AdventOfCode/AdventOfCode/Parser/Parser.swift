import Foundation

public struct Parser<Input, Output> {
	public let run: (inout Input) -> Output?
	
	public init(run: @escaping (inout Input) -> Output?) {
		self.run = run
	}
}
