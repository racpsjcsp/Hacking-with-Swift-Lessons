//
//  ViewController.swift
//  Project5 - TUTORIAL APP
//
//  Created by Rafael Plinio on 27/04/20.
//  Copyright © 2020 Rafael Plinio. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add a left bar button that restarts the game with a new word (using func startGame)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        let errorTitle: String
        let errorMessage: String
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    if isLong(word: lowerAnswer) {
                    
                        usedWords.insert(lowerAnswer, at: 0)
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        
                        return
                        
                        } else {
                            errorTitle = "Too short!"
                            errorMessage = "Must be above 3 letters"
                        }
                    } else {
                        errorTitle = "Word not recognized!"
                        errorMessage = "You can't just make them up..."
                    }
                } else {
                    errorTitle = "Word already used"
                    errorMessage = "Be more orignal ;)"
                }
            } else {
                errorTitle = "Word not possible!"
                errorMessage = "You can't spell that word from \(title!.lowercased())."
            }
            
            let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
        }
    
    //compare if the word is possible
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    //compare if the word is original
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    //compare if the word is real
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    //compare if the word has more than 3 letters
    func isLong(word: String) -> Bool {
        if word.count > 3 {
            return true
        } else {
            return false
        }
    }
    
    //func showErrorMessage(word: String) -> Bool {
    //    var errorTitle = String()
    //    var errorMessage = String()
    //
    //    var ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
    //
    //    if isPossible(word: word) == false {
    //        errorTitle = "Word not possible!"
    //        errorMessage = "You can't spell that word from \(title!.lowercased())."
    //        ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
    //        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    //        present(ac, animated: true)
    //        return false
    //    } else if isOriginal(word: word) == false {
    //        errorTitle = "Word already used"
    //        errorMessage = "Be more orignal ;)"
    //        present(ac, animated: true)
    //        return false
    //    } else if isReal(word: word) == false {
    //        errorTitle = "Word not recognized!"
    //        errorMessage = "You can't just make them up..."
    //        present(ac, animated: true)
    //        return false
    //    } else if isLong(word: word) == false {
    //        errorTitle = "Too short!"
    //        errorMessage = "Must be above 3 letters"
    //        present(ac, animated: true)
    //        return false
    //    } else {
    //        return true
    //    }
    //}
}


