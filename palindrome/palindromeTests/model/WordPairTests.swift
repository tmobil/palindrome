//
//  WordPairTests.swift
//  palindrome
//
//  Created by Wojtek Chmielewski on 08/10/2018.
//  Copyright © 2018 Wojtek Chmielewski. All rights reserved.
//

import XCTest
@testable import palindrome

class WordPairTests: XCTestCase {

    func testDescription() {
        XCTAssertEqual(WordsPair(first: "first", second: "second").description, "{first, second} = {firstsecond}")
    }

    func testAllPairs() {
        XCTAssertEqual(WordsPair.allPairs(firstArray: [], second: "a"), [])
        XCTAssertEqual(WordsPair.allPairs(firstArray: ["z"], second: "a"), [WordsPair(first: "z", second: "a")])
        XCTAssertEqual(WordsPair.allPairs(firstArray: ["z", "x"], second: "a"),
                       [WordsPair(first: "z", second: "a"), WordsPair(first: "x", second: "a")])
    }

}
