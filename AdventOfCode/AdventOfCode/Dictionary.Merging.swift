import Foundation

extension Dictionary {
    public func merging(with dict: [Key: Value]) -> [Key: Value] {
        return merging(dict, uniquingKeysWith: { (current, _) in current })
    }
}
