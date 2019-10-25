//
//  Card.swift
//  Concentration
//
//  Created by Anastasia Reyngardt on 01/10/2019.
//  Copyright © 2019 GermanyHome. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var upside = 0
    
    private static var identifierFactory = 0
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    private static func getUniqueIdentifier() -> Int  {
        Card.identifierFactory += 1
        return identifierFactory
    }
}
