//
//  LetterNodeTests.swift
//  LetterNodeTests
//
//  Created by Wojtek Chmielewski on 08/10/2018.
//  Copyright © 2018 Wojtek Chmielewski. All rights reserved.
//

import XCTest
@testable import palindrome

class LetterNodeTests: XCTestCase {

    var root: LetterNode = LetterNode()

    override func setUp() {
        root = LetterNode()
    }

    func testAddAndCheckWords_ordinaryWord() {
        root.addWord("ordinaryWord")
        XCTAssertTrue(root.checkWord("ordinaryWord"))
        XCTAssertFalse(root.checkWord("anotherWord"))
        XCTAssertFalse(root.checkWord("ordinary"))
        XCTAssertFalse(root.checkWord("ordinaryWordPlusSomeCharacters"))
        XCTAssertFalse(root.checkWord(""))
    }

    func testAddAndCheckWords_emptyWordIsAllowed() {
        root.addWord("")
        XCTAssertTrue(root.checkWord(""))
    }

    func testFindNode() {
        root.addWord("word")
        XCTAssertNotNil(root.findNode(prefix: "wo"))
        XCTAssertNotNil(root.findNode(prefix: "word"))
        XCTAssertNil(root.findNode(prefix: "wordx"))
    }

    func testAllWordsStarting() {
        let testWords: Set<String> = ["a", "ab", "abc", "abx", "abcz", "abcx", "abcdefg"]
        for word in testWords {
            root.addWord(word)
        }

        let result: Set<String> = Set(root.allWordsStarting())

        XCTAssertEqual(result, testWords)
    }
}
