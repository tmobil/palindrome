//
//  WordsPair.swift
//  palindrome
//
//  Created by Wojtek Chmielewski on 08/10/2018.
//  Copyright © 2018 Wojtek Chmielewski. All rights reserved.
//

import Foundation

struct WordsPair : CustomStringConvertible, Hashable {
    var first: String
    var second: String

    var description: String {
        return "{\(first), \(second)} = {\(first + second)}"
    }

    static func allPairs(firstArray: [String], second: String) -> [WordsPair] {
        return firstArray.map{ WordsPair(first: $0, second: second)}
    }
}
