//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Wombat on 4/27/25.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable
{
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent)
    {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards)
        {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int?
    {
        get
        {
            return cards.indices.filter { index in cards[index].isFaceUp }.only
        }
        set
        {
            return cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}
        }
    }
    
    mutating func choose(card: Card)
    {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id })
        {
            if (!cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched)
            {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard
                {
                    if (cards[chosenIndex].content == cards[potentialMatchIndex].content)
                    {
                        cards[chosenIndex].isMatched = true;
                        cards[potentialMatchIndex].isMatched = true;
                    }
                }
                else
                {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle()
    {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible
    {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var debugDescription: String
        {
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? " matched" : "")"
        }
       
        var id: String
    }
}

extension Array
{
    var only : Element?
    {
        return count == 1 ? first : nil
    }
}
