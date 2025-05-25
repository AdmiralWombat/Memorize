//
//  CardView.swift
//  Memorize
//
//  Created by Wombat on 5/7/25.
//
import SwiftUI

struct CardView : View {
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    
    init(_ card: Card)
    {
        self.card = card
    }
    
    
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 1/5))
        {
            timeline in
            if (card.isFaceUp || !card.isMatched)
            {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(Constants.Pie.opacity)
                    .overlay(cardContents.padding(Constants.Pie.inset))
                    .padding(Constants.inset)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.scale)
            }
            else
            {
                Color.clear
            }
        }
    }
    
    private var cardContents: some View
    {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
            
            .rotationEffect(.degrees(card.isMatched ? 360: 0))
            .animation(.spin(duration: 1), value: card.isMatched)
    }
    
    struct CardView_Previews: PreviewProvider
    {
        typealias Card = CardView.Card
        
        static var previews: some View
        {
            VStack
            {
                HStack {
                    CardView(Card(isFaceUp: true, content: "X", id: "test1"))
                    CardView(Card(content: "X", id: "test1"))
                }
                HStack {
                    CardView(Card(content: "X", id: "test1"))
                    CardView(Card(content: "X", id: "test1"))
                }
            }
                .padding()
                .foregroundColor(.green)
        }
    }
    
    private struct Constants
    {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct Pie {
            static let inset: CGFloat = 5
            static let opacity: CGFloat = 0.4
        }
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
    }
}
extension Animation
{
    static func spin(duration: TimeInterval) -> Animation
    {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}
