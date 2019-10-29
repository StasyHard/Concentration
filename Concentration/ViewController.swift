//
//  ViewController.swift
//  Concentration
//
//  Created by Anastasia Reyngardt on 30/09/2019.
//  Copyright © 2019 GermanyHome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            if game.isGameOver() {
                newGameButton.isHidden = false
            }
            updateViewFromModel()
        } else {
            print("Карта не в массиве")
        }
    }
    
    @IBAction private func NewGameButton(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emojiChoices = ViewController.defaultEmojies
        emoji.removeAll()
        updateViewFromModel()
        newGameButton.isHidden = true
    }
    
    //вместо массива указала многомерный массив и беру рандомно элемент из него
    private static let emojiesArray = [
        [ "👻", "😱", "🤐", "👽", "😈", "🎃", "🙀", "👾", "👺" ],
        [ "🐶", "🐨", "🐒", "🐷", "🐸", "🦀", "🐬", "🦊", "🦋" ],
        [ "🍇", "🍒", "🥑", "🥐", "🥩", "🍕", "🍝", "🥗", "🥦" ],
        [ "😃", "😍", "😎", "🧐", "🤪", "🥺", "😳", "🤗", "🤒" ],
        [ "⚽️", "🏀", "⚾️", "🎾", "🏐", "🏉", "🥏", "🎱", "🏓" ]
    ]
    
    private static var defaultEmojies = emojiesArray.randomElement()!
    private var emojiChoices: [String] = defaultEmojies
    
    private func updateViewFromModel() {
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
        //кладу новый массив при обновлении вью
        ViewController.defaultEmojies = ViewController.emojiesArray.randomElement()!
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    private var emoji = [Card: String]()
    //Card реализует протокол Hashable, что позволяет осуществлять поиск не по идентификатору а по карте
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform (UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform (UInt32(self)))
        } else {
            return 0
        }
    }
}
