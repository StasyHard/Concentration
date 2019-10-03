//
//  ViewController.swift
//  Concentration
//
//  Created by Anastasia Reyngardt on 30/09/2019.
//  Copyright © 2019 GermanyHome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count + 1 / 2)
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            //вызываю функцию, которая проверяет все ли карты isMatched
        } else { print("Карта не в массиве")
        }
    }
    
    func updateViewFromModel() {
        for index in 0...cardButtons.indices.count - 1 {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }

    var emojiChoices = [ "👻", "😱", "🤐", "👽", "😈", "🎃", "🙀", "👾", "👺" ]
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
            if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                let randomeIndex = Int(arc4random_uniform (UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomeIndex)
            }
               return emoji[card.identifier] ?? "?"
        }
    
    @IBAction func NewGameButton(_ sender: UIButton) {
        
    }
    


}

