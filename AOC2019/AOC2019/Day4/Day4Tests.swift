//
//  Day4Tests.swift
//  AOC2019Tests
//
//  Created by mark.sands on 12/3/19.
//  Copyright © 2019 type440. All rights reserved.
//

import XCTest
import AOC2019

class Day4Tests: XCTestCase {
    func testOne() {
        let day = Day4(from: 109165, to: 576723)
        XCTAssertEqual("2814", day.part1())
    }
    
    func testTwo() {
        let day = Day4(from: 109165, to: 576723)
        XCTAssertEqual("1991", day.part2())
    }

}
