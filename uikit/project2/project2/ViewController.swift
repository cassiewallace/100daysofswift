//
//  ViewController.swift
//  project2
//
//  Created by Cassie Wallace on 10/7/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "checkmark.circle.badge.questionmark.fill"), target: self, action: #selector(seeScoreTapped))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        // TODO: Project 6: Autolayout broke the borders.
        // button1.layer.borderWidth = 1
        // button2.layer.borderWidth = 1
        // button3.layer.borderWidth = 1
        
        // button1.layer.borderColor = UIColor.lightGray.cgColor
        // button2.layer.borderColor = UIColor.lightGray.cgColor
        // button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
    
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        questionsAsked += 1
        
        title = "\(countries[correctAnswer].uppercased()) - Score: \(score)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)."
        } else {
            title = "Wrong"
            score -= 1
            message = "Nope! That's the flag of \(countries[correctAnswer].capitalized)."
        }
    
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }

    @objc func seeScoreTapped() {
    
        let ac = UIAlertController(title: "Your score is: \(score)", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
}

