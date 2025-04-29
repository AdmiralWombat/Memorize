//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Wombat on 4/27/25.
//

import SwiftUI



class EmojiMemoryGame : ObservableObject
{
    private static let halloweenEmojis = ["👻", "🕷️", "🎃", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    private static let farmEmojis = ["🐖", "🐐", "🐰", "🐴", "🐓", "🦃", "🚜", "🐑", "🐄", "🧑‍🌾", "🫏", ]
    private static let sportsEmojis = ["⚽️", "🏈", "🏀", "⚾️", "🎾", "🏐", "🏓", "🏸", "🏒", "🥊"]
    
    private static let emojis = ["👻", "🕷️", "🎃", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    
    private static func createMemoryGame() -> MemoryGame<String>
    {
        return MemoryGame(numberOfPairsOfCards: 5)
        {
            pairIndex in
            if (emojis.indices.contains(pairIndex))
            {
                return emojis[pairIndex]
            }
            else
            {
                return "⚠️"
            }
                
        }
    }
    
    @Published private var model = createMemoryGame()

    var cards: Array<MemoryGame<String>.Card>
    {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card)
    {
        model.choose(card: card)
    }
    
    // MARK: - Intents
    
    func shuffle()
    {
        model.shuffle()
    }
}
