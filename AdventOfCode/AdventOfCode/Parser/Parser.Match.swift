extension Parser where Input == Substring {
  public func match(_ input: String) -> Output? {
    var input = input[...]
    return self.run(&input)
  }
}
