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
    var isFaceUp : Bool = false
    
    var body: some View {
        ZStack() {
            if (isFaceUp)
            {
                RoundedRectangle(cornerRadius: 12).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12).strokeBorder(lineWidth: 2)
                Text("👻").font(.largeTitle)
            }
            else
            {
                RoundedRectangle(cornerRadius: 12)
            }
        }
        
    }
}
