import UIKit
import Foundation
import AdventOfCode

enum False {
}

struct Not<A> {
    let not: (A) -> False
}

func f<A>(x: A) -> Not<Not<A>> {
    return Not { not_a in
        return not_a.not(x)
    }
}
