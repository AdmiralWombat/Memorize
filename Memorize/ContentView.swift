//
//  ContentView.swift
//  Memorize
//
//  Created by Wombat on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻", "🕷️", "🎃", "😈"]
    
    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self)
            {
                index in
                CardView(content: emojis[index], isFaceUp: true)
            }
            
        }
        .foregroundColor(.orange)
        .padding()
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
            if (isFaceUp)
            {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            else
            {
                base.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
