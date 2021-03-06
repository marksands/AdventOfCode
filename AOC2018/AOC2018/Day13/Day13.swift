import Foundation

public enum IntersectionDirection {
    case left
    case straight
    case right
}

public enum Direction: String {
    case left = "<"
    case up = "^"
    case right = ">"
    case down = "v"
    
    public static func isCart(_ value: String) -> Bool {
        return value == Direction.left.rawValue ||
            value == Direction.up.rawValue ||
            value == Direction.right.rawValue ||
            value == Direction.down.rawValue
    }
}

public class Cart {
    public var row: Int
    public var col: Int
    public var currentDirection = Direction.down
    var lastDirectionOfIntersection = IntersectionDirection.right
    
    init(row: Int, col: Int, direction: Direction) {
        self.row = row
        self.col = col
        self.currentDirection = direction
    }
    
    func collision(with cart: Cart) -> Bool {
        guard !crashed else { return false }
        return cart.row == row && cart.col == col
    }
    
    var crashed = false
}

public final class Day13: Day {
    public var track: [[String]] = []
    public var carts: [Cart] = []
    
    public init(input: String = Input().rawInput()) {
        track = input.components(separatedBy: .newlines).map {
            String($0).map { String($0) }
        }
        
        super.init()
        
        zip(track.indices, track).forEach { y, row in
            zip(row.indices, row).forEach { x, element in
                if Direction.isCart(element) {
                    let cart = Cart(row: y, col: x, direction: Direction(rawValue: element)!)
                    carts.append(cart)

                    switch cart.currentDirection {
                    case .left, .right:
                        track[y][x] = "-"
                    case .up, .down:
                        track[y][x] = "|"
                    }
                }
            }
        }
        
        carts.sort(by: { ($0.row, $0.col) < ($1.row, $1.col) })
    }

    @discardableResult
    public func step() -> (crash: CGPoint?, carts: [Cart]) {
        carts.sort(by: { ($0.row, $0.col) < ($1.row, $1.col) })
        
        for cart in carts {
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
            
            if track[cart.row][cart.col] == "/" {
                if cart.currentDirection == .up {
                    cart.currentDirection = .right
                } else if cart.currentDirection == .left {
                    cart.currentDirection = .down
                } else if cart.currentDirection == .right {
                    cart.currentDirection = .up
                } else if cart.currentDirection == .down {
                    cart.currentDirection = .left
                }
            } else if track[cart.row][cart.col] == "\\" {
                if cart.currentDirection == .up {
                    cart.currentDirection = .left
                } else if cart.currentDirection == .left {
                    cart.currentDirection = .up
                } else if cart.currentDirection == .right {
                    cart.currentDirection = .down
                } else if cart.currentDirection == .down {
                    cart.currentDirection = .right
                }
            } else if track[cart.row][cart.col] == "|" {
                switch cart.currentDirection {
                case .up, .down:
                    break
                case .left, .right:
                    fatalError("Invalid direction")
                }
            } else if track[cart.row][cart.col] == "-" {
                switch cart.currentDirection {
                case .up, .down:
                    fatalError("Invalid direction")
                case .left, .right:
                    break
                }
            } else if track[cart.row][cart.col] == "+" {
                switch cart.lastDirectionOfIntersection {
                case .left:
                    cart.lastDirectionOfIntersection = .straight
                case .right:
                    cart.lastDirectionOfIntersection = .left
                    
                    if cart.currentDirection == .up {
                        cart.currentDirection = .left
                    } else if cart.currentDirection == .down {
                        cart.currentDirection = .right
                    } else if cart.currentDirection == .right {
                        cart.currentDirection = .up
                    } else if cart.currentDirection == .left {
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
            }
            
            for (index, cart) in carts.enumerated() {
                for (index2, cart2) in carts.enumerated() {
                    if index != index2 && cart.collision(with: cart2) {
                        cart.crashed = true
                        cart2.crashed = true
                    }
                }
            }
        }

        let crashPoint = carts.first(where: { $0.crashed }).map { CGPoint(x: $0.col, y: $0.row) }
        carts.removeAll(where: { $0.crashed })
        
        return (crash: crashPoint, carts: carts)
    }
    
    public func printGrid() -> String {
        var outerResult = ""
        zip(track.indices, track).forEach { y, row in
            var result = ""
            zip(row.indices, row).forEach { x, element in
                if let cart = carts.first(where: { cart in cart.col == x && cart.row == y }) {
                    result += cart.currentDirection.rawValue
                } else {
                    result += element
                }
            }
            outerResult += result + "\n"
        }
        return outerResult
    }
}
