//
//  ViewController.swift
//  challenge3
//
//  Created by Cassie Wallace on 10/12/22.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Outlet(s)
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var remainingGuessesLabel: UILabel!
    @IBOutlet var incorrectGuessesLabel: UILabel!
    
    // MARK: Private Var(s)
    private var words = [String]()
    private var wordCharacters = String().enumerated()
    
    private var incorrectGuesses = [String]() {
        didSet {
            incorrectGuessesLabel.text = """
            Incorrect Guesses:
            \(incorrectGuesses.joined(separator: " "))
            """
        }
    }
    
    private var guessesRemaining = 7 {
        didSet {
            remainingGuessesLabel.text = "Guesses Remaining: \(guessesRemaining)"
        }
    }
    
    private var word = "" {
        didSet {
            wordCharacters = word.enumerated()
            displayedWord = ""
            for _ in word {
                displayedWord.append("?")
            }
        }
    }
    
    private var displayedWord = "" {
        didSet {
            wordLabel.text = displayedWord
        }
    }
    
    // MARK: Public Func(s)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hangman"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(startGame))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let guessButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptGuess))

        navigationController?.isToolbarHidden = false
        toolbarItems = [spacer, guessButton, spacer]
        
        performSelector(inBackground: #selector(loadWords), with: nil)
    
        DispatchQueue.main.async {
            self.startGame()
        }
    }
        
    // MARK: Private Func(s)
    @objc private func loadWords() {
        if let wordsURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let wordsFile = try? String(contentsOf: wordsURL) {
                words = wordsFile.components(separatedBy: "\n")
            }
        }

        if words.isEmpty {
            words = ["swift"]
        }
    }
    
    @objc private func startGame() {
        guessesRemaining = 7
        incorrectGuesses = []
        word = words.randomElement()!
    }
    
    @objc private func startGamePressed(action: UIAlertAction) {
        startGame()
    }
    
    @objc private func promptGuess() {
        let ac = UIAlertController(title: "Make a guess", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let guessAction = UIAlertAction(title: "Guess", style: .default) {
            [weak ac, weak self] _ in
            guard let guessLetter = ac?.textFields?[0].text else { return }
            guard guessLetter.count == 1 else { return }
            self?.guess(guessLetter)
        }
        
        ac.addAction(guessAction)
        present(ac, animated: true)
    }

    private func guess(_ guessedLetter: String) {
        guard !incorrectGuesses.contains(guessedLetter) else { return }
        
        if word.contains(guessedLetter) {
            for (n, x) in wordCharacters {
                if String(x) == guessedLetter {
                    var strchars = Array(displayedWord)
                    strchars[n] = Character(guessedLetter)
                    displayedWord = String(strchars)
                }
            }
        } else {
            incorrectGuesses.append(guessedLetter)
            guessesRemaining -= 1
        }
    
        if !displayedWord.contains("?") {
            showResult(win: true)
        } else if guessesRemaining == 0 {
            showResult(win: false)
        }
    }
    
    private func showResult(win: Bool) {
        let ac = UIAlertController(title: (win ? "You won!" : "You lost!"), message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "New Game", style: .default, handler: startGamePressed))
        present(ac, animated: true)
    }
    
}
