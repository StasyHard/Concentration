//
//  Concentration.swift
//  Concentration
//
//  Created by Anastasia Reyngardt on 01/10/2019.
//  Copyright © 2019 GermanyHome. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    var flipCount = 0
    
    
    func chooseCard(at index: Int) {
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // функционал функции, которая проверяет все ли карты isMatched
    func isGameOver() -> Bool {
        for currentCard in cards {
            if currentCard.isMatched == false {
                return false
            }
        }
        return true
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards = cards.shuffled()
    }
    
}
