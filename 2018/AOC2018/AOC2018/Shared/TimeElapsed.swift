import CoreFoundation

public func printRunningTime<T>(_ title: String, _ operation: () -> (T)) -> T {
    let startTime = CFAbsoluteTimeGetCurrent()
    defer {
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Time elapsed for \(title): \(timeElapsed)s.")
    }
    return operation()
}
