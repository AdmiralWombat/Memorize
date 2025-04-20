//
//  ContentView.swift
//  Memorize
//
//  Created by Wombat on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

#Preview {
    ContentView()
}

struct CardView : View {
    @State var isFaceUp = false
    
    var body: some View {
        ZStack() {
            let base = RoundedRectangle(cornerRadius: 12)
            if (isFaceUp)
            {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text("👻").font(.largeTitle)
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
