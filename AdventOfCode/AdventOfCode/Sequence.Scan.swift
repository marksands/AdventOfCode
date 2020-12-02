extension Sequence {
    public func scan<ResultElement>(_ initial: ResultElement, _ nextPartialResult: (ResultElement, Element) -> ResultElement) -> [ResultElement] {
        return reduce(into: [initial], { result, next in
            result.append(nextPartialResult(result.last!, next))
        })
    }
}

public struct LazyScanIterator<Base : IteratorProtocol, ResultElement> : IteratorProtocol {
    private var nextElement: ResultElement?
    private var base: Base
    private let nextPartialResult: (ResultElement, Base.Element) -> ResultElement

    public init(nextElement: ResultElement?, base: Base, _ nextPartialResult: @escaping (ResultElement, Base.Element) -> ResultElement) {
        self.nextElement = nextElement
        self.base = base
        self.nextPartialResult = nextPartialResult
    }
    
    public mutating func next() -> ResultElement? {
        return nextElement.map { result in
            nextElement = base.next().map { nextPartialResult(result, $0) }
            return result
        }
    }
}

public struct LazyScanSequence<Base: Sequence, ResultElement> : LazySequenceProtocol {
    private let initial: ResultElement
    private let base: Base
    private let nextPartialResult: (ResultElement, Base.Element) -> ResultElement

    public init(initial: ResultElement, base: Base, _ nextPartialResult: @escaping (ResultElement, Base.Element) -> ResultElement) {
        self.initial = initial
        self.base = base
        self.nextPartialResult = nextPartialResult
    }
    
    public func makeIterator() -> LazyScanIterator<Base.Iterator, ResultElement> {
        return LazyScanIterator(nextElement: initial, base: base.makeIterator(), nextPartialResult)
    }
}

extension LazySequenceProtocol {
    public func scan<ResultElement>(_ initial: ResultElement, _ nextPartialResult: @escaping (ResultElement, Element) -> ResultElement) -> LazyScanSequence<Self, ResultElement> {
        return LazyScanSequence(initial: initial, base: self, nextPartialResult)
    }
}
