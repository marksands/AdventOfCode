import Foundation
import AdventOfCode

public final class Day7: Day {
    class inode: CustomDebugStringConvertible {
        var isDirectory: Bool = false
        var name: String = ""
        var nodes: [inode] = []
        var size: Int = -1
        weak var parent: inode? = nil

        init(name: String, isDirectory: Bool = false, nodes: [inode] = [], size: Int = -1) {
            self.name = name
            self.isDirectory = isDirectory
            self.nodes = nodes
            self.size = size
        }

        var recursiveSize: Int {
            if !isDirectory {
                return size
            } else {
                return nodes.reduce(0, { $0 + $1.recursiveSize })
            }
        }

        var level: Int {
            var r = 0
            var p = parent
            while p != nil {
                r += 1
                p = p?.parent
            }
            return r
        }

        func visit(_ command: (inode) -> ()) {
            command(self)
            for node in nodes {
                node.visit(command)
            }
        }

        var debugDescription: String {
            var result = ""
            if isDirectory {
                result += "\(String(repeating: "  ", count: level * 2) )- \(name) (dir Y)\n"
            } else {
                result += "\(String(repeating: "  ", count: level * 2) )- \(name) (file, size=\(size))\n"
            }
            for node in nodes {
                result += node.debugDescription
            }
            return result
        }
    }

    private let lines: [String]

    var root: inode!
    var sizes: [Int] = []

    public init(rawInput: [String] = Input().trimmedInputCharactersByNewlines()) {
        self.lines = rawInput
        super.init()

        var parent = inode(name: "/", isDirectory: true)
        root = parent

        for line in lines {
            if line.starts(with: "$") { // command
                let commandParts = line.components(separatedBy: " ")
                if commandParts[1] == "cd" {
                    if commandParts[2] == ".." { // go up
                        parent = parent.parent!
                    } else if commandParts[2] == "/" { // go to root
                        parent = root
                    } else { // go to child
                        parent = parent.nodes.first(where: { $0.name == commandParts[2] && $0.isDirectory })!
                    }
                } else if commandParts[1] == "ls" {
                    // no-op
                }
            } else { // inode
                if line.first?.isNumber ?? false { // file with size
                    let fileParts = line.components(separatedBy: " ")
                    let node = inode(name: fileParts.last!, size: fileParts.first!.int)
                    node.parent = parent
                    parent.nodes.append(node)
                } else { // assume dir?
                    let dirParts = line.components(separatedBy: " ")
                    let node = inode(name: dirParts.last!, isDirectory: true)
                    node.parent = parent
                    parent.nodes.append(node)
                }
            }
        }

        root.visit({ node in
            if node.isDirectory {
                sizes.append(node.recursiveSize)
            }
        })

        print("tree:\n", root!)
    }

    public override func part1() -> String {
        return sizes.filter({ $0 <= 100_000 }).sum().string
    }

    public override func part2() -> String {
        let remainingSpace = 70_000_000 - root.recursiveSize
        let requiredSpaceToDelete = 30_000_000 - remainingSpace
        return sizes.filter { $0 >= requiredSpaceToDelete }.min()!.string
    }
}
