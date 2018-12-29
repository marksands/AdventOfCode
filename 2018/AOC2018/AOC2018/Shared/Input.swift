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
    
    public func inputCharactersByNewlines(fromFile file: StaticString = #file) -> [String] {
        return rawInput(fromFile: file).components(separatedBy: .newlines)
    }
    
    public func trimmedInputCharactersByNewlines(fromFile file: StaticString = #file) -> [String] {
        return trimmedRawInput(fromFile: file).components(separatedBy: .newlines)
    }
}
