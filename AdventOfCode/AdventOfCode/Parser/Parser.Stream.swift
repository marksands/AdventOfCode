extension Parser where Input: RangeReplaceableCollection {
	public var stream: Parser<AnyIterator<Input>, [Output]> {
		return .init { stream in
			var buffer = Input()
			var outputs: [Output] = []

			while let chunk = stream.next() {
				buffer.append(contentsOf: chunk)

				while let output = self.run(&buffer) {
					outputs.append(output)
				}
			}

			return outputs
		}
	}
}
