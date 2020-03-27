//
//  Card.swift
//  Concentration
//
//  Created by Anastasia Reyngardt on 01/10/2019.
//  Copyright © 2019 GermanyHome. All rights reserved.
//

import Foundation

struct Card: Hashable {

    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    var upside = 0
    
    private static var identifierFactory = 0
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    //функции == и hash реализуют протокол Hashable
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    private static func getUniqueIdentifier() -> Int  {
        Card.identifierFactory += 1
        return identifierFactory
    }
    
    
}
