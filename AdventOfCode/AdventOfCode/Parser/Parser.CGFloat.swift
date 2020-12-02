import CoreGraphics

extension Parser where Input == Substring, Output == CGFloat {
	public static let cgFloat = Self { input in
		let original = input
		let sign: CGFloat
		if input.first == "-" {
			sign = -1
			input.removeFirst()
		} else if input.first == "+" {
			sign = 1
			input.removeFirst()
		} else {
			sign = 1
		}
		
		var decimalCount = 0
		let prefix = input.prefix { char in
			if char == "." { decimalCount += 1 }
			return char.isNumber || (char == "." && decimalCount <= 1)
		}
		
		guard let match = Double(prefix) else {
			input = original
			return nil
		}
		
		input.removeFirst(prefix.count)
		
		return CGFloat(match) * sign
	}
}
