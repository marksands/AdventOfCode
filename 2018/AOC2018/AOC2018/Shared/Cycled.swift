public func cycled<T>(_ input: [T]) -> UnfoldSequence<T, Int> {
    return sequence(state: 0, next: { currentIndex -> T? in
        let computedIndex = currentIndex % input.count
        currentIndex += 1
        return input[computedIndex]
    })
}
