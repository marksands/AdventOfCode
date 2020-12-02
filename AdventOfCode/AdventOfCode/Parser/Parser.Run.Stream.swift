extension Parser where Input: RangeReplaceableCollection {
	public func run(
		input: inout AnyIterator<Input>,
		output streamOut: @escaping (Output) -> Void
	) {
		var buffer = Input()
		while let chunk = input.next() {
			buffer.append(contentsOf: chunk)

			while let output = self.run(&buffer) {
				streamOut(output)
			}
		}
	}
}
