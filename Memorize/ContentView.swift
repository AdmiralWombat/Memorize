//
//  ContentView.swift
//  Memorize
//
//  Created by Wombat on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    let halloweenEmojis: Array<String> = ["👻", "🕷️", "🎃", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    let farmEmojis: Array<String> = ["🐖", "🐐", "🐰", "🐴", "🐓", "🦃", "🚜", "🐑", "🐄", "🧑‍🌾", "🫏", ]
    let sportsEmojis: Array<String> = ["⚽️", "🏈", "🏀", "⚾️", "🎾", "🏐", "🏓", "🏸", "🏒", "🥊"]
    
    @State var cardBackgroundColor: Color = .orange

    @State var emojis: Array<String> = []
    
    @State var themeChosen: Int = 0
    
    @State var cardCount: Int = 4
    
    init()
    {
        emojis = halloweenEmojis + halloweenEmojis;
        
        randomizeDeck(deckTheme: halloweenEmojis, backgroundColor: .orange)
    
    }
    
    var body: some View {
        
        VStack
        {
            title
            themeChoosers
            ScrollView
            {
                cards
            }
            Spacer()
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
            themeButton(icon: "powersleep", title: "Halloween", action: halloweenEmojis, backgroundColor: .orange)
            themeButton(icon: "carrot", title: "Farm", action: farmEmojis, backgroundColor: .green)
            themeButton(icon: "basketball.fill", title: "Sports", action: sportsEmojis, backgroundColor: .black)
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
        print (cardWidth)
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: cardWidth))]) {
            ForEach(0..<emojis.count, id: \.self)
            {
                index in
                CardView(content: emojis[index], isFaceUp: false)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(cardBackgroundColor)
    }
}

#Preview {
    ContentView()
}



struct CardView : View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack() {
            let base = RoundedRectangle(cornerRadius: 12)
            Group
            {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
