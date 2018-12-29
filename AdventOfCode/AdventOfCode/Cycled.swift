public func cycled<T>(_ input: [T]) -> UnfoldSequence<T, Int> {
    return sequence(state: 0, next: { currentIndex -> T? in
        defer { currentIndex += 1 }
        return input[currentIndex % input.count]
    })
}
