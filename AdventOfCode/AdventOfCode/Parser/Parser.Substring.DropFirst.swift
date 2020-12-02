extension Parser
where Input: Collection,
      Input.SubSequence == Input,
      Output == Input {
  public func dropFirst(_ k: Int = 1) -> Self {
    return .init { input in
      guard input.count >= k else { return nil }
      let substring = input.dropFirst(k)
      input.removeFirst(k)
      return substring
    }
  }
}
