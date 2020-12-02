extension Parser
where Input: Collection,
      Input.Element: Equatable,
      Input.SubSequence == Input,
      Output == Void {
  public static func prefix(_ p: Input) -> Self {
    Self { input in
      guard input.starts(with: p) else { return nil }
      input.removeFirst(p.count)
      return ()
    }
  }
}
