//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Wombat on 4/17/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    @State var cardBackgroundColor: Color = .orange

    @State var emojis: Array<String> = []
    
    @State var themeChosen: Int = 0
    
    @State var cardCount: Int = 4
    
    var body: some View {
        
        VStack
        {
            title
            themeChoosers
            ScrollView
            {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            Button("Shuffle")
            {
                viewModel.shuffle()
            }
            //cardCountAdjusters
            
        }.padding()
    }
    
    var title: some View
    {
        Text("Memorize").font(.largeTitle).bold()
    }
    
    var themeChoosers: some View
    {
        HStack
        {
            //themeButton(icon: "powersleep", title: "Halloween", action: halloweenEmojis, backgroundColor: .orange)
            //themeButton(icon: "carrot", title: "Farm", action: farmEmojis, backgroundColor: .green)
            //themeButton(icon: "basketball.fill", title: "Sports", action: sportsEmojis, backgroundColor: .black)
        }
    }
    
    func randomizeDeck(deckTheme: Array<String>, backgroundColor: Color)
    {
        let emojisRandom = deckTheme.shuffled()
        cardCount = 6//Int.random(in: 2...deckTheme.count)
        let emojisTrimmed = Array(emojisRandom[0..<cardCount])
        
       
        emojis = emojisTrimmed + emojisTrimmed
        emojis.shuffle()
        cardBackgroundColor = backgroundColor
    }
    
    func themeButton(icon: String, title: String, action: Array<String>, backgroundColor: Color) -> some View
    {
        VStack
        {
            Button(action: {
                randomizeDeck(deckTheme: action, backgroundColor: backgroundColor)
            }, label: {
                Image(systemName: icon).font(.largeTitle)
            })
            Text(title).font(.subheadline)
        }
    }
    
    func widthThatBestFits(count: Int) -> CGFloat
    {
        
        return (-60.0 / 7.0) * (Double(count)) + (1020.0/7.0)
    }
    
    var cards: some View
    {
        let cardWidth = widthThatBestFits(count: cardCount)

        return LazyVGrid(columns: [GridItem(.adaptive(minimum: cardWidth), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards)
            {
                card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(cardBackgroundColor)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}



struct CardView : View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card)
    {
        self.card = card
    }
    
    var body: some View {
        ZStack() {
            let base = RoundedRectangle(cornerRadius: 12)
            Group
            {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content).font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
            
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}
