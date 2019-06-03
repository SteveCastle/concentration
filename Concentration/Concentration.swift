//
//  Concentration.swift
//  Concentration
//
//  Created by Stephen Castle on 6/2/19.
//  Copyright © 2019 Stephen Castle. All rights reserved.
//

import Foundation

class Concentration {
   private(set) var cards = [Card]()
    
    // Example of computed propery with get and set.
    private var indexOfOnlyFaceUpCard: Int? {
        get {
            var foundIndex : Int?
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
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Card index not in cards array.")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                 cards[matchIndex].isMatched = true
                 cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
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
