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
    var score = 0
  
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
                        score+=2 + cards[chosenIndex].bonus + cards[potentialMatchIndex].bonus
                    }
                    else
                    {
                        if (cards[chosenIndex].isSeen)
                        {
                            score -= 1
                        }
                        if (cards[potentialMatchIndex].isSeen)
                        {
                            score -= 1
                        }
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
    
    func cardStatus()
    {
        for index in cards.indices
        {
            print (cards[index])
        }
    }
    
    mutating func newGame()
    {
        cards.shuffle()
        for index in cards.indices
        {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            
        }
        indexOfTheOneAndOnlyFaceUpCard = nil
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible
    {
        var isFaceUp = false
        {
            didSet
            {
                if (isFaceUp)
                {
                    startUsingBonusTime()
                }
                else
                {
                    stopUsingBonusTime()
                }
                if (oldValue && !isFaceUp)
                {
                    isSeen = true
                }
            }
        }
        var isMatched = false
        {
            didSet
            {
                if (isMatched)
                {
                    stopUsingBonusTime()
                }
            }
        }
        var isSeen = false
        let content: CardContent
        
        private mutating func startUsingBonusTime()
        {
            if isFaceUp && !isMatched && bonusPercentRemaining > 0, lastFaceUpDate == nil
            {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime()
        {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
        var bonus: Int{
            Int(bonusTimeLimit * bonusPercentRemaining)
        }
        
        var bonusPercentRemaining: Double
        {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime) / bonusTimeLimit : 0
        }
        
        var faceUpTime: TimeInterval
        {
            if let lastFaceUpDate
            {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            }
            else
            {
                return pastFaceUpTime
            }
        }
        
        var bonusTimeLimit: TimeInterval = 6
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        
        
        var debugDescription: String
        {
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? " matched" : "") \(isSeen ? "seen" : "not seen")"
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
