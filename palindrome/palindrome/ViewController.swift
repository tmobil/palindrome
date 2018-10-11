//
//  ViewController.swift
//  palindrome
//
//  Created by Wojtek Chmielewski on 08/10/2018.
//  Copyright © 2018 Wojtek Chmielewski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logView: UITextView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressLabel: UILabel!

    // storage into two copies for better performance - list for iteration, tree for searching
    var wordsList: [String] = []
    let wordsStorage: LetterNode = LetterNode()
    var progress: Int = 0 {
        didSet {
            if progress != oldValue {
                DispatchQueue.main.async {
                    self.progressLabel.text = "\(self.progress)%"
                }
            }
        }
    }

    //result
    var palindromePairs: [WordsPair] = []

    struct Configuration {
        static let SKIP_WHITESPACES = true
        static let LOWERCASE = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        logView.text = ""
        updateLoading(show: true)

        let backgroundQueue = DispatchQueue(label: "com.app.queue", qos: .background)
        backgroundQueue.async {
            let rawWords = self.wordsFromFile()
            self.createWordsStorage(rawWords: rawWords)
            self.searchPalindromePairs()

            DispatchQueue.main.async {
                self.updateLoading(show: false)
            }
        }
    }

    func updateLoading(show: Bool) {
        logView.isUserInteractionEnabled = show ? false : true
        logView.backgroundColor = show ? UIColor.lightGray : UIColor.clear
        if show {
            logView.isUserInteractionEnabled = false
            logView.backgroundColor = UIColor.lightGray
            loadingIndicator.isHidden = false
            progressLabel.isHidden = false
        } else {
            logView.isUserInteractionEnabled = true
            logView.backgroundColor = UIColor.clear
            loadingIndicator.isHidden = true
            progressLabel.isHidden = true
        }
    }

    func displayLog(_ log: String) {
        DispatchQueue.main.async {
            self.logView.insertText(log + "\n")
        }
    }

    func wordsFromFile() -> [String] {
        displayLog("Loading file...")

        let wordsProvider: WordsProvider = WordsProvider.loadLocalFile()

        displayLog("Loaded \(wordsProvider.words.count) words.")

        return wordsProvider.words
    }

    func createWordsStorage(rawWords: [String]) {
        displayLog("Adding into storage...")

        for word in rawWords {
            var formattedWord = word
            if Configuration.SKIP_WHITESPACES {
                formattedWord = formattedWord.trimmingCharacters(in: .whitespaces)
            }
            if Configuration.LOWERCASE {
                formattedWord = formattedWord.lowercased()
            }

            wordsList.append(formattedWord)
            wordsStorage.addWord(formattedWord)
        }

        displayLog("All words added into storage.")
    }

    func searchPalindromePairs() {
        displayLog("Searching palindrome pairs for all words...")

        var counter = 0
        for word in wordsList {
            let finder = PalindromFinder(secondWord: word, words: wordsStorage)
            palindromePairs += finder.searchAllPalindromePairs()
            counter += 1
            progress = 100 * counter / wordsList.count
        }

        displayLog("Found: \(palindromePairs.count) pairs.\n")
        let logWithAllPairs = palindromePairs.reduce("") { (log, pair) -> String in
            return log + "\(pair.description)\n"
        }
        displayLog(logWithAllPairs)
    }
}

