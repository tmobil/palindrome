//
//  PalindromFinder.swift
//  palindrome
//
//  Created by Wojtek Chmielewski on 08/10/2018.
//  Copyright © 2018 Wojtek Chmielewski. All rights reserved.
//

import Foundation

class PalindromFinder {

    private var secondWord: String
    private var wordsStorage: LetterNode

    // as we have words in tree sorted form first leeter to last, is easier to set second word and find the first
    init(secondWord: String, words: LetterNode) {
        self.secondWord = secondWord
        self.wordsStorage = words
    }

    // returns all words to build a palindrome with length less of second word lenght
    func palindromFirstWordsShorter() -> [String] {
        var firstWords: [String] = []
        let reversedSecondWord = secondWord.reversed()
        for firstWordLength in 1..<secondWord.count {
            let possibleFirstWord: String = String(reversedSecondWord.prefix(firstWordLength))
            let joined = possibleFirstWord + secondWord
            if wordsStorage.checkWord(possibleFirstWord) && joined.isPalindrome() {
                firstWords.append(String(possibleFirstWord))
            }
        }
        return firstWords
    }

    // returns all words to build a palindrome with length more or equal of second word lenght
    func palindromFirstWordsLongerOrEqual() -> [String] {
        let firstWordPrefix = secondWord.reversed()
        let firstWordPrefixNode: LetterNode? = wordsStorage.findNode(prefix: String(firstWordPrefix))
        if let startedNode = firstWordPrefixNode {
            let suffixes: [String] = startedNode.allWordsStarting()
            return suffixes.filter{ $0.isPalindrome() }.map { firstWordPrefix + $0 }
        } else {
            return []
        }
    }

    func searchAllPalindromePairs() -> [WordsPair] {
        var firstWords = palindromFirstWordsShorter() + palindromFirstWordsLongerOrEqual()

        // don't allow to create pair with the same word on first and second position e.g {a, a} or {eye, eye}
        firstWords = firstWords.filter{ $0 != secondWord}

        return WordsPair.allPairs(firstArray: firstWords, second: secondWord)
    }
}
