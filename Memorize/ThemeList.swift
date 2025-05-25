//
//  ThemeList.swift
//  Memorize
//
//  Created by Wombat on 5/23/25.
//

import SwiftUI

struct ThemeList: View
{
    @EnvironmentObject var store: ThemeStore
    @State private var showCursorTheme = false
    
    var body: some View
    {
        NavigationStack
        {
            List
            {
                ThemeListItemView
            }
            .navigationDestination(for: MemoryTheme.self)
            {
                memoryTheme in
                //ThemeView(memoryTheme: memoryTheme)
                EmojiMemoryGameView(viewModel: EmojiMemoryGame(memoryTheme: memoryTheme))
                
            }
            .navigationDestination(isPresented: $showCursorTheme)
            {
                ThemeEditor(memoryTheme: $store.memoryThemes[store.cursorIndex])
            }
            .navigationTitle("\(store.name) Themes")
            .toolbar
            {
                Button {
                    store.insert(name: "", color: RGBA(color: .black), emojis: [], numberOfPairs: 0, at: 0)
                    showCursorTheme = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
        }
    }
    
    private var ThemeListItemView: some View
    {
        ForEach(store.memoryThemes)
        {
            memoryTheme in
            NavigationLink(value: memoryTheme)
            {
                VStack(alignment: .leading)
                {
                    Text(memoryTheme.themeName)
                        .foregroundColor(Color(rgba: memoryTheme.themeColor))
                    HStack
                    {
                        
                        Text(memoryTheme.numberOfPairs == memoryTheme.emoji.count ? "All of " : "\(memoryTheme.numberOfPairs) pairs from ")
                        Text(memoryTheme.emoji.joined()).lineLimit(1)
                    }
                }
            }
        }
        .onDelete
        {
            indexSet in
            withAnimation
            {
                store.memoryThemes.remove(atOffsets: indexSet)
            }
        }
        .onMove
        {
            indexSet, newOffset in
            store.memoryThemes.move(fromOffsets: indexSet, toOffset: newOffset)
        }
    }
}
	
struct ThemeView: View
{
    let memoryTheme: MemoryTheme
    
    var body: some View
    {
        VStack
        {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))])
            {
                ForEach(Array(memoryTheme.emoji), id: \.self)
                {
                    emoji in
                    NavigationLink(value: emoji)
                    {
                        Text(emoji)
                    }
                }
                
            }
            .navigationDestination(for: String.self)
            {
                emoji in
                Text(emoji).font(.system(size: 300))
            }
            Spacer()
            
        }
        .padding()
        .font(.largeTitle)
        .navigationTitle(memoryTheme.themeName)
    }
}

#Preview {
    ThemeList()
}
