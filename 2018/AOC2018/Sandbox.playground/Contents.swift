import UIKit
import Foundation
import AOC2018

let input = """
/->-\\
|   |  /----\\
| /-+--+-\\  |
| | |  | v  |
\\-+-/  \\-+--/
  \\------/
"""

// TODO: input is missing whitespace gaps, is that okay...?
var grid = input.components(separatedBy: .newlines).map {
    String($0).map { String($0) }
}

enum IntersectionDirection {
    case left
    case straight
    case right
}

enum Direction: String {
    case left = "<"
    case up = "^"
    case right = ">"
    case down = "v"
    
    static func isCart(_ value: String) -> Bool {
        return value == Direction.left.rawValue ||
            value == Direction.up.rawValue ||
            value == Direction.right.rawValue ||
            value == Direction.down.rawValue
    }
}

class Cart {
    var row: Int
    var col: Int
    var currentDirection = Direction.down
    var lastDirectionOfIntersection = IntersectionDirection.right // so the first time will flip to left
    
    init(row: Int, col: Int, direction: Direction) {
        self.row = row
        self.col = col
        self.currentDirection = direction
    }
    
    func collision(with cart: Cart) -> Bool {
        return cart.row == row && cart.col == col
    }
}

var carts: [Cart] = []

zip(grid.indices, grid).forEach { y, row in
    zip(row.indices, row).forEach { x, element in
        if Direction.isCart(element) {
            let cart = Cart(row: y, col: x, direction: Direction(rawValue: element)!)
            carts.append(cart)
            switch cart.currentDirection {
            case .left, .right:
                grid[y][x] = "-"
            case .up, .down:
                grid[y][x] = "|"
            }
        }
    }
}

print(grid)

carts.forEach { cart in
    print("c: \(cart.row),\(cart.col) - d: \(cart.currentDirection)")
}


func step() {
    carts.forEach { cart in
        switch cart.currentDirection {
        case .left:
            cart.col -= 1
        case .right:
            cart.col += 1
        case .up:
            cart.row -= 1
        case .down:
            cart.row += 1
        }
        
        if grid[cart.row][cart.col] == "/" {
            if cart.currentDirection == .up {
                cart.currentDirection = .right
            } else if cart.currentDirection == .left {
                cart.currentDirection = .down
            } else if cart.currentDirection == .right {
                cart.currentDirection = .up
            } else if cart.currentDirection == .down {
                cart.currentDirection = .left
            }
        } else if grid[cart.row][cart.col] == "\\" {
            if cart.currentDirection == .up {
                cart.currentDirection = .left
            } else if cart.currentDirection == .left {
                cart.currentDirection = .up
            } else if cart.currentDirection == .right {
                cart.currentDirection = .down
            } else if cart.currentDirection == .down {
                cart.currentDirection = .right
            }
        } else if grid[cart.row][cart.col] == "|" {
            switch cart.currentDirection {
            case .up, .down: break // keep going!
            case .left, .right:
                fatalError("Invalid direction")
            }
        } else if grid[cart.row][cart.col] == "-" {
            switch cart.currentDirection {
            case .up, .down:
                fatalError("Invalid direction")
            case .left, .right:
                break // keep going!
            }
        } else if grid[cart.row][cart.col] == "+" {
            switch cart.lastDirectionOfIntersection {
            case .left:
                cart.lastDirectionOfIntersection = .straight
                 // no change to cart current direction
            case .right:
                cart.lastDirectionOfIntersection = .left
                
                if cart.currentDirection == .up {
                    cart.currentDirection = .left
                } else if cart.currentDirection == .down {
                    cart.currentDirection = .right
                } else if cart.currentDirection == .right {
                    cart.currentDirection = .up
                } else if cart.currentDirection == .left {
                    // relative-left
                    cart.currentDirection = .down
                }

            case .straight:
                cart.lastDirectionOfIntersection = .right

                if cart.currentDirection == .up {
                    cart.currentDirection = .right
                } else if cart.currentDirection == .down {
                    cart.currentDirection = .left
                } else if cart.currentDirection == .right {
                    cart.currentDirection = .down
                } else if cart.currentDirection == .left {
                    cart.currentDirection = .up
                }
            }
                
//            case .left: // if was left, then go straight
//                if cart.currentDirection == .up {
//                    cart.lastDirectionOfIntersection = .up
//                    cart.currentDirection = .up
//                } else if cart.currentDirection == .down {
//                    cart.lastDirectionOfIntersection = .down
//                    cart.currentDirection = .down
//                } else if cart.currentDirection == .left {
//                    cart.lastDirectionOfIntersection = .down // really should be 'straight', doesn't matter?
//                    cart.currentDirection = .left
//                } else if cart.currentDirection == .right {
//                    cart.lastDirectionOfIntersection = .down // really should be 'straight', doesn't matter?
//                    cart.currentDirection = .right
//                }
//            case .right: // if was right, then go left
//                cart.lastDirectionOfIntersection = .left
//
//                if cart.currentDirection == .up {
//                    cart.currentDirection = .left
//                } else if cart.currentDirection == .down {
//                    // upside-down left
//                    cart.currentDirection = .right
//                } else if cart.currentDirection == .right {
//                     // relative-left
//                    cart.currentDirection = .up
//                } else if cart.currentDirection == .left {
//                    // relative-left
//                    cart.currentDirection = .down
//                }
//            case .up: // if was straight up, then go right
//                cart.lastDirectionOfIntersection = .right
//                cart.currentDirection = .right
//            case .down: // if was straight down, then go right
//                cart.lastDirectionOfIntersection = .right
//                cart.currentDirection = .right
//            }
        } else {
            fatalError("HMMM")
        }


        carts.enumerated().forEach { index, cart in
            if carts.enumerated().filter({ $0.0 != index }).reduce(false, { $0 || $1.element.collision(with: cart) }) {
                print("BOOM!: \(cart.col),\(cart.row)")
            }
        }
    }
}

func print() {
    print(grid)
    carts.forEach { cart in
        print("c: \(cart.col), \(cart.row) - d: \(cart.currentDirection)")
    }
}

(0..<20).forEach { _ in
    step()
//    print()
}
