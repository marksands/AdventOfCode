extension Parser
where Input: Collection,
      Input.SubSequence == Input,
      Output == Input {
  public static func prefix(while p: @escaping (Input.Element) -> Bool) -> Self {
    Self { input in
      let output = input.prefix(while: p)
      input.removeFirst(output.count)
      return output
    }
  }
}
