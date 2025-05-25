//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Wombat on 4/17/25.
//

import SwiftUI

@main
struct MemorizeApp: App {
    //@StateObject var game = EmojiMemoryGame()
    @StateObject var themeStore = ThemeStore(named: "Memory")
    
    var body: some Scene {
        WindowGroup {
            //EmojiMemoryGameView(viewModel: game)
            ThemeList()
                .environmentObject(themeStore)
        }
    }
}
