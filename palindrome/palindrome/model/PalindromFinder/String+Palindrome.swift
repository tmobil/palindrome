//
//  String+Palindrome.swift
//  palindrome
//
//  Created by Wojtek Chmielewski on 08/10/2018.
//  Copyright © 2018 Wojtek Chmielewski. All rights reserved.
//

import Foundation

extension String {

    func isPalindrome() -> Bool {
        guard let first: Character = self.first, let last: Character = self.last else {
            //treat empty string as palindrome
            return true
        }
        if self.count == 1 {
            //one letter string is palindrome
            return true
        }
        if first != last {
            //the first must be equal last mandatory
            return false
        }

        return String(self.dropFirst().dropLast()).isPalindrome()
    }
}
