import Foundation
import AdventOfCode
import Vision

public final class Day8: Day {
    private let layers = Array(Input().trimmedRawInput()).chunks(ofSize: 25 * 6)
    
    public override func part1() -> String {
        let fewestZeros = layers.min(by: { $0.count { $0 == "0" } < $1.count { $0 == "0" } })!
        return String(fewestZeros.count { String($0) == "1" } * fewestZeros.count { String($0) == "2" })
    }
    
    public override func part2() -> String {
        var picture = Array(repeating: "2", count: 25 * 6)
        layers.forEach { layer in
            picture = zip(picture, layer).map { p, l in
                return p == "2" ? String(l) : p
            }
        }
        picture.chunks(ofSize: 25).forEach { row in
            print(row.map({ $0 == "0" ? "⬛️" : "⬜️" }).joined())
        }
        return ""
    }
    
    public func NOT_WORKING_part2() -> String {
        var picture = Array(repeating: "", count: 25 * 6)
        
        layers.reversed().forEach { layer in
            picture = zip(picture, layer).map { p, l in
                return l == "0" ? "0" : l == "1" ? "1" : p
            }
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        var result = ""
        
        let request = VNRecognizeTextRequest(completionHandler: { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            for observation in observations {
                guard let candidate = observation.topCandidates(1).first else { continue }
                result += candidate.string
            }
            
            semaphore.signal()
        })

        request.recognitionLevel = .accurate

        let handler = VNImageRequestHandler(cgImage: layerToImage(picture).cgImage!, options: [:])
        try? handler.perform([request])
        
        semaphore.wait()
        
        return result
    }
    
    private func layerToImage(_ layer: [String]) -> UIImage {
        let scale = 1
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 25 * scale, height: 6 * scale), true, 0)
        defer { UIGraphicsEndImageContext() }
        
        let context = UIGraphicsGetCurrentContext()
        
        layer.chunks(ofSize: 25).enumerated().forEach { (i, row) in
            for (j, element) in row.enumerated() {
                if element == "0" {
                    context?.setFillColor(UIColor.black.cgColor)
                } else {
                    context?.setFillColor(UIColor.white.cgColor)
                }
                context?.fill(CGRect(x: j*scale, y: i*scale, width: scale, height: scale))
            }
        }
        
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}

//⬜️⬛️⬛️⬛️⬛️⬜️⬜️⬜️⬜️⬛️⬛️⬜️⬜️⬛️⬛️⬛️⬛️⬜️⬜️⬛️⬜️⬛️⬛️⬛️⬜️
//⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬛️⬜️
//⬜️⬛️⬛️⬛️⬛️⬜️⬜️⬜️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️
//⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬜️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬜️⬛️⬛️
//⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬛️⬜️⬛️⬛️
//⬜️⬜️⬜️⬜️⬛️⬜️⬜️⬜️⬜️⬛️⬛️⬜️⬜️⬜️⬛️⬛️⬜️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️
