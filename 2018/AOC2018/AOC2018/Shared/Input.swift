import Foundation

public struct Input {
    public let inputFilename = "input"
    
    public init() { }
    
    public func rawInput(fromFile file: StaticString = #file) -> String {
        let pathComponents = Array(("\(file)" as NSString).pathComponents.dropLast())
        guard let fileURL = NSURL.fileURL(withPathComponents: pathComponents)?.appendingPathComponent(inputFilename) else {
            fatalError("Invalid input file! Unable to create file path from \(pathComponents).")
        }
        guard let inputContents = try? String(contentsOf: fileURL) else {
            fatalError("Invalid file contents! Unable to extract contents from \(fileURL).")
        }
        return inputContents
    }
        
    public func trimmedRawInput(fromFile file: StaticString = #file) -> String {
        return rawInput(fromFile: file).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public func separated(by separator: String, fromFile file: StaticString = #file) -> [String] {
        return rawInput(fromFile: file).components(separatedBy: separator)
    }
    
    public func separated(by characterSet: CharacterSet, fromFile file: StaticString = #file) -> [String] {
        return rawInput(fromFile: file).components(separatedBy: characterSet)
    }

    public func inputCharactersByNewlines(fromFile file: StaticString = #file) -> [String] {
        return separated(by: .newlines, fromFile: file)
    }
    
    public func inputCharactersByComma(fromFile file: StaticString = #file) -> [String] {
        return trimmedRawInput(fromFile: file).components(separatedBy: ",")
    }
    
    public func trimmedInputCharactersByNewlines(fromFile file: StaticString = #file) -> [String] {
        return trimmedRawInput(fromFile: file).components(separatedBy: .newlines)
    }

    public func inputIntegersByNewlines(fromFile file: StaticString = #file) -> [Int] {
        return inputCharactersByNewlines(fromFile: file).compactMap(Int.init)
    }
    
    public func inputIntegersByComma(fromFile file: StaticString = #file) -> [Int] {
        return inputCharactersByComma(fromFile: file).compactMap(Int.init)
    }
}
