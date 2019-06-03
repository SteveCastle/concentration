//
//  Concentration.swift
//  Concentration
//
//  Created by Stephen Castle on 6/2/19.
//  Copyright © 2019 Stephen Castle. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var indexOfOnlyFaceUpCard: Int?
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                 cards[matchIndex].isMatched = true
                 cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _  in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
