//
//  AdventOfCodeTests.swift
//  AdventOfCodeTests
//
//  Created by mark.sands on 12/28/18.
//  Copyright © 2018 mark.sands. All rights reserved.
//

import XCTest
@testable import AdventOfCode

class AdventOfCodeTests: XCTestCase {

    func desiredOutput(_ newMac: String) -> String {
        return """
        sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
        sudo ifconfig en0 ether \(newMac)
        networksetup -detectnewhardware
        """
    }
    
    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let mappings = """
54:4e:90:c8:a5:f6
34:12:98:50:38:9f
3c:2e:ff:6b:ad:9a
0:f7:6f:ea:9c:a4
cc:20:e8:e:6:2a
f8:e9:4e:96:15:4e
bc:9f:ef:81:a0:e9
9c:e6:5e:14:db:74
f8:38:80:6f:db:27
8c:7c:92:58:7c:9a
18:65:90:29:6c:aa
"""
        
        mappings.components(separatedBy: CharacterSet.newlines).forEach { ma in
            print(desiredOutput(ma))
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}








//possibly working one
//sudo ifconfig en0 ether fc:18:3c:69:54:43
//sudo ifconfig en0 ether 64:70:33:37:f:18
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 8c:85:90:0:b:7f
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//
//sudo ifconfig en0 ether 40:83:1d:da:aa:af
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 80:b0:3d:d7:aa:97
//
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether f8:34:41:65:bd:73
//networksetup -detectnewhardware
//
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether bc:9f:ef:81:a0:e9
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//
//sudo ifconfig en0 ether 58:40:4e:9d:63:56
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether f0:98:9d:4c:18:5c
//
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 9c:e6:5e:14:db:74
//networksetup -detectnewhardware
//
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether d8:1c:79:f2:9c:7d
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//
//sudo ifconfig en0 ether 8:c5:e1:3f:47:30
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether e4:2b:34:84:bc:88
//
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 18:74:2e:84:96:ac
//networksetup -detectnewhardware
//
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether d0:c5:f3:2a:99:92
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//
//sudo ifconfig en0 ether dc:a9:4:cb:68:94
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 68:fe:f7:ee:67:68
//
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 5c:f5:da:7f:33:8e
//networksetup -detectnewhardware
//
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 7c:1:91:80:a9:62
//networksetup -detectnewhardware
//
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 18:65:90:d3:ba:83
//networksetup -detectnewhardware
//
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether cc:44:63:d2:35:2b
//networksetup -detectnewhardware
//
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 30:d9:d9:1c:a4:2d
//networksetup -detectnewhardware
//
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 54:e4:3a:b6:e9:53
//networksetup -detectnewhardware
//
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 8c:85:90:e7:9c:5d
//networksetup -detectnewhardware
//
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether a0:c9:a0:b8:fb:1d
//networksetup -detectnewhardware
//
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 6c:96:cf:da:23:5d
//networksetup -detectnewhardware
//
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether c4:84:66:d4:9a:34
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 8c:7c:92:58:7c:9a
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 54:33:cb:1:e8:5a
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 74:b5:87:4a:c4:eb
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 18:65:90:29:6c:aa
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 98:e0:d9:cc:60:b2
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 2c:1f:23:5a:94:7e
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 68:db:ca:9b:82:be
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 80:b0:3d:19:ee:d0
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether e4:9a:dc:ee:2f:c8
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 98:1:a7:83:46:1a
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether 64:9a:be:a6:2e:c0
//networksetup -detectnewhardware
//sudo /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -z
//sudo ifconfig en0 ether ff:ff:ff:ff:ff:ff
//networksetup -detectnewhardware




