//
//  PalindromFinderTests.swift
//  palindrome
//
//  Created by Wojtek Chmielewski on 08/10/2018.
//  Copyright © 2018 Wojtek Chmielewski. All rights reserved.
//

import XCTest
@testable import palindrome

class PalindromFinderTests: XCTestCase {

    static let testWords = ["a", "b", "ab", "ba", "abc", "abcc", "abcd", "abcde", "abcded", "abcdedc"]
    lazy var words: LetterNode = {
        let root = LetterNode()
        for word in PalindromFinderTests.testWords {
            root.addWord(word)
        }
        return root
    }()

    func testPalindromFirstWordsShorter() {
        performTestPalindromFirstWordsShorter(input: "ccba", expected: ["ab", "abc"])
        performTestPalindromFirstWordsShorter(input: "cba", expected: ["ab"])
        performTestPalindromFirstWordsShorter(input: "a", expected: [])
    }

    func testPalindromFirstWordsLongerOrEqual() {
        performTestPalindromFirstWordsLongerOrEqual(input: "ccba", expected: ["abcc"])
        performTestPalindromFirstWordsLongerOrEqual(input: "cba", expected: ["abcd", "abcded", "abc", "abcc"])
        performTestPalindromFirstWordsLongerOrEqual(input: "a", expected: ["a", "ab"])
    }

    func testPalindromSearchAllPalindromePairs() {
        performTestSearchAllPalindromePairs(input: "ccba", expected: WordsPair.allPairs(firstArray: ["ab", "abc", "abcc"], second: "ccba"))
        performTestSearchAllPalindromePairs(input: "cba", expected: WordsPair.allPairs(firstArray: ["ab", "abc", "abcd", "abcded", "abc", "abcc"], second: "cba"))
        performTestSearchAllPalindromePairs(input: "a", expected: WordsPair.allPairs(firstArray: ["ab"], second: "a"))
    }

    func testPalindromSearchAllPalindromePairs_short() {
        let finder = PalindromFinder(secondWord: "a", words: words)
        let expected = WordsPair.allPairs(firstArray: ["ab"], second: "a")

        let result = finder.searchAllPalindromePairs()

        XCTAssertEqualRegardlessPosition(result, expected)
    }

    // helper for comparing arrays elements regardless position for no repeating elements
    func XCTAssertEqualRegardlessPosition<T: Hashable>(_ array1: Array<T>, _ array2:Array<T>) {
        XCTAssertEqual(Set<T>(array1), Set<T>(array2))
    }

    // helper for perform test palindromFirstWordsShorter()
    func performTestPalindromFirstWordsShorter(input: String, expected: [String]) {
        let finder = PalindromFinder(secondWord: input, words: words)
        let result = finder.palindromFirstWordsShorter()
        XCTAssertEqualRegardlessPosition(result, expected)
    }

    // helper for perform test palindromFirstWordsLongerOrEqual()
    func performTestPalindromFirstWordsLongerOrEqual(input: String, expected: [String]) {
        let finder = PalindromFinder(secondWord: input, words: words)
        let result = finder.palindromFirstWordsLongerOrEqual()
        XCTAssertEqualRegardlessPosition(result, expected)
    }

    // helper for perform test searchAllPalindromePairs()
    func performTestSearchAllPalindromePairs(input: String, expected: [WordsPair]) {
        let finder = PalindromFinder(secondWord: input, words: words)
        let result = finder.searchAllPalindromePairs()
        XCTAssertEqualRegardlessPosition(result, expected)
    }
}
