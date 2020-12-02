extension Parser {
	public static func oneOf(_ ps: [Self]) -> Self {
		.init { input in
			for p in ps {
				if let match = p.run(&input) {
					return match
				}
			}
			return nil
		}
	}
	
	public static func oneOf(_ ps: Self...) -> Self {
		self.oneOf(ps)
	}
}
