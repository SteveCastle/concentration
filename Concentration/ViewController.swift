//
//  ViewController.swift
//  Concentration
//
//  Created by Stephen Castle on 6/2/19.
//  Copyright © 2019 Stephen Castle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)

    //Example of a computed property infering read only.
    var numberOfPairsOfCards : Int {
        return (cardButtons.count / 2)
    }


    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "\(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            print("cardNumber:\(cardNumber)")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiChoices: Array<String> = ["👻","🎃","🗝","⛈", "🏚", "🔪"]
    private var emoji = Dictionary<Int, String>()
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                // Using an extension on Int
                emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4Random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

// Defining an extension on Int.
extension Int {
    var arc4Random: Int {
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))

        }
        return 0
    }
}
