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

    @State var emojis: Array<String>
    
    @State var cardCount: Int = 4
    @State var themeChosen: Int = 0
    
    init()
    {
        emojis = halloweenEmojis + halloweenEmojis;
        emojis.shuffle()
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
            themeButton(icon: "powersleep", title: "Halloween", action: halloweenEmojis)
            themeButton(icon: "carrot", title: "Farm", action: farmEmojis)
            themeButton(icon: "basketball.fill", title: "Sports", action: sportsEmojis)
        }
    }
    
    func themeButton(icon: String, title: String, action: Array<String>) -> some View
    {
        VStack
        {
            Button(action: {
                emojis = action + action
                emojis.shuffle()
            }, label: {
                Image(systemName: icon).font(.largeTitle)
            })
            Text(title).font(.subheadline)
        }
    }
    
    var cards: some View
    {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(0..<emojis.count, id: \.self)
            {
                index in
                CardView(content: emojis[index], isFaceUp: true)
                    .aspectRatio(4/5, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View
    {
        HStack
        {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View
    {
        return Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View
    {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
        
    }
    
    var cardAdder: some View
    {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus")
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
