//
//  String+PalindromeTests.swift
//  palindrome
//
//  Created by Wojtek Chmielewski on 08/10/2018.
//  Copyright © 2018 Wojtek Chmielewski. All rights reserved.
//

import XCTest
@testable import palindrome

class StringPalindromeTests: XCTestCase {

    func testIsPalindrome() {
        XCTAssertFalse("someword".isPalindrome())

        XCTAssertTrue("qwertytrewq".isPalindrome())
        XCTAssertTrue("qwertyytrewq".isPalindrome())

        XCTAssertFalse("qwertyXtrewq".isPalindrome())
        XCTAssertFalse("qwertXytrewq".isPalindrome())
        XCTAssertFalse("qwetXtrewq".isPalindrome())
    }

    func testIsPalindrome_shortWords() {
        XCTAssertTrue("".isPalindrome())
        XCTAssertTrue("a".isPalindrome())
        XCTAssertTrue("aa".isPalindrome())
        XCTAssertFalse("ab".isPalindrome())
    }

}
