extension Parser where Input == Substring, Output == Int {
	public static let int = Self { input in
		let original = input

		let sign: Int // +1, -1
		if input.first == "-" {
			sign = -1
			input.removeFirst()
		} else if input.first == "+" {
			sign = 1
			input.removeFirst()
		} else {
			sign = 1
		}

		let intPrefix = input.prefix(while: \.isNumber)
		guard let match = Int(intPrefix)
		else {
			input = original
			return nil
		}
		input.removeFirst(intPrefix.count)
		return match * sign
	}
}
