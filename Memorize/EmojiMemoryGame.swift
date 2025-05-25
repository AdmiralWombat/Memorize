//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Wombat on 4/27/25.
//

import SwiftUI



class EmojiMemoryGame : ObservableObject
{
    typealias Card = MemoryGame<String>.Card
    
    @Published private var model : MemoryGame<String>
    private var theme : MemoryTheme
    
    init(memoryTheme: MemoryTheme)
    {
        //let defaultTheme = setTheme[0]
        //theme = setTheme.randomElement() ?? defaultTheme
        
        //let defaultTheme = MemoryTheme.builtins[0]
        //theme = MemoryTheme.builtins.randomElement() ?? defaultTheme
        theme = memoryTheme
        
        model = EmojiMemoryGame.createMemoryGame(gameTheme: theme)

    }
    
    private static func createMemoryGame(gameTheme : MemoryTheme) -> MemoryGame<String>
    {
        let emojis = gameTheme.emoji.shuffled()
        return MemoryGame(numberOfPairsOfCards: gameTheme.numberOfPairs)
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
    
    

    var cards: Array<Card>
    {
        return model.cards
    }
    
    var themeName: String
    {
        return theme.themeName
    }
    
    var themeColor: Color
    {
        return Color(rgba: theme.themeColor)
    }
    
    var score: Int
    {
        return model.score
    }
    
    func choose(_ card: Card)
    {
        model.choose(card: card)
    }
    
    // MARK: - Intents
    
    func shuffle()
    {
        model.shuffle()
    }
    
    func newGame()
    {
       
        /*let defaultTheme = MemoryTheme.builtins[0]
        theme = MemoryTheme.builtins.randomElement() ?? defaultTheme
        
        model = EmojiMemoryGame.createMemoryGame(gameTheme: theme)
        model.shuffle()*/
   
    }
}
