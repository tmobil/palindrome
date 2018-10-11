//
//  WordsProvider.swift
//  palindrome
//
//  Created by Wojtek Chmielewski on 08/10/2018.
//  Copyright © 2018 Wojtek Chmielewski. All rights reserved.
//

import Foundation

class WordsProvider {

    private(set) var words: [String] = []

    static func loadLocalFile() -> WordsProvider {
        let loader = WordsProvider()
        if let path = Bundle.main.path(forResource: "english", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, Array<String>> {
                    loader.words = Array(jsonResult.keys)
                }
            } catch {
                print("Loading error")
            }
        }
        return loader
    }
}
