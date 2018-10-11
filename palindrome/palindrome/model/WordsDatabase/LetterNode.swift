//
//  LetterNode.swift
//  palindrome
//
//  Created by Wojtek Chmielewski on 08/10/2018.
//  Copyright © 2018 Wojtek Chmielewski. All rights reserved.
//

import Foundation

// For better performance in word searching all words are stored in tree where level of nodes defines next possible letters
class LetterNode {
    private var nodes: [Character: LetterNode]
    private var ending: Bool
    
    init() {
        nodes = [:]
        ending = false
    }
    
    private func nextLetterNode(_ letter: Character) -> LetterNode {
        if let nextLetterNode = nodes[letter] {
            return nextLetterNode
        }
        let letterNode: LetterNode = LetterNode()
        nodes[letter] = letterNode
        return letterNode
    }
    
    func addWord(_ word: String) {
        if let nextLetter: Character = word.first {
            nextLetterNode(nextLetter).addWord(String(word.dropFirst()))
        } else {
            ending = true
        }
    }
    
    func checkWord(_ word: String) -> Bool {
        if let nextLetter: Character = word.first {
            if let nextLetterNode = nodes[nextLetter] {
                return nextLetterNode.checkWord(String(word.dropFirst()))
            } else {
                return false
            }
        } else {
            return ending
        }
    }
}

// advanced searching
extension LetterNode {

    // return node for words started with given prefix or nil if node not exist
    func findNode(prefix: String) -> LetterNode? {
        let possibleNextLetter: Character? = prefix.first
        if let nextLetter = possibleNextLetter {
            if let nextLetterNode = nodes[nextLetter] {
                return nextLetterNode.findNode(prefix: String(prefix.dropFirst()))
            } else {
                return nil
            }
        } else {
            return self
        }
    }

    private func allWordsStarting(additionalPrefix: String) -> [String] {
        var result: [String] = []
        for (nextLetter, nextNode) in nodes {
            let subNodeResult: [String] = nextNode.allWordsStarting(additionalPrefix: additionalPrefix + String(nextLetter))
            result += subNodeResult
        }
        if ending {
            result.append(additionalPrefix)
        }
        return result
    }

    func allWordsStarting() -> [String] {
        return allWordsStarting(additionalPrefix: "")
    }
}
