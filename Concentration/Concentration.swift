//
//  Concentration.swift
//  Concentration
//
//  Created by Anastasia Reyngardt on 01/10/2019.
//  Copyright © 2019 GermanyHome. All rights reserved.
//

import Foundation

class Concentration {
    
    private (set) var cards = [Card]()
    //считает очки
    private (set) var score = 0
    private (set) var flipCount = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set (newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards = cards.shuffled()
    }
    
    func chooseCard(at index: Int) {
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    // добавляю 2 очка если карты совпали
                    score += 2
                } else {
                    cards[index].upside += 1
                    cards[matchIndex].upside += 1
                    if cards[index].upside > 1 && cards[matchIndex].upside > 1 {
                        score -= 2
                    } else if cards[index].upside > 1 || cards[matchIndex].upside > 1  {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
            } else {
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
    
    func updateScoreAndFlipCount() {
        if isGameOver() == true {
            score = 0
            flipCount = 0
        }
    }
}
