public var lowercaseLetters: [String] = "abcdefghijklmnopqrstuvwxyz".exploded()
public var uppercaseLetters: [String] = lowercaseLetters.map { $0.uppercased() }
