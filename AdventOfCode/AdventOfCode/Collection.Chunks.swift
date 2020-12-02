extension Strideable {
    func advanced(by stride: Stride, limitedBy: Self) -> Self {
        return distance(to: limitedBy) < stride ? limitedBy : self.advanced(by: stride)
    }
}

extension Range where Bound : Strideable {
    public func chunks(ofSize chunkSize: Bound.Stride) -> [Range] {
        return stride(from: self.lowerBound, to: self.upperBound, by: chunkSize).map { currentStride in
            let strideEnd = currentStride.advanced(by: chunkSize, limitedBy: self.upperBound)
            return currentStride ..< strideEnd
        }
    }
}

extension Collection where Index: Strideable {
    public func chunks(ofSize chunkSize: Index.Stride) -> [SubSequence] {
        return (self.startIndex ..< self.endIndex).chunks(ofSize: chunkSize).map { self[$0] }
    }
}
