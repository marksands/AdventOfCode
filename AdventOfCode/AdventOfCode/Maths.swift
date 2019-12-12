public func lcm<T: BinaryInteger>(_ m: T, _ n: T) -> T {
    return m / gcd(m, n) * n

}

public func lcm<T: BinaryInteger, C: Collection>(_ collection: C) -> T where C.Element == T {
    guard let first = collection.first else { fatalError("Collection is empty!") }
    return collection.dropFirst().reduce(first) { lcm($0, $1) }
}

public func gcd<T: BinaryInteger>(_ m: T, _ n: T) -> T {
    var a: T = 0
    var b: T = max(m, n)
    var r: T = min(m, n)

    while r != 0 {
        a = b
        b = r
        r = a % b
    }
    
    return b
}

public func gcd<T: BinaryInteger, C: Collection>(_ collection: C) -> T where C.Element == T {
    guard let first = collection.first else { fatalError("Collection is empty!") }
    return collection.dropFirst().reduce(first) { gcd($0, $1) }
}
