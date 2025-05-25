//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Wombat on 5/23/25.
//

import SwiftUI

struct ThemeEditor: View
{
    @Binding var memoryTheme: MemoryTheme
    
    @State private var emojisToAdd: String = ""
    
    enum Focused
    {
        case name
        case addEmojis
    }
    @FocusState private var focused: Focused?
    
    var body: some View
    {
        Form
        {
            Section(header: Text("Name"))
            {
                TextField("Name", text: $memoryTheme.themeName)
                    .focused($focused, equals: .name)
            }
            
            Section(header: Text("Emojis"))
            {
                TextField("Add Emojis Here", text: $emojisToAdd)
                    .onChange(of: emojisToAdd)
                    {

                        //memoryTheme.emoji = (emojisToAdd + memoryTheme.emoji.joined()).map({String($0)})
                        let newEmojis = Set(emojisToAdd.map { String($0) })
                        memoryTheme.emoji.formUnion(newEmojis)
                        emojisToAdd = ""
                    }
                    .focused($focused, equals: .addEmojis)
                removeEmojis
            }
        }
    }
    
    var removeEmojis: some View
    {
        VStack(alignment: .trailing)
        {
            Text("Tap to Remove Emojis").font(.caption).foregroundColor(.gray)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))])
            {
                ForEach(Array(memoryTheme.emoji) as [String], id: \.self)
                {
                    (emoji: String) in
                    Text(emoji)
                        .onTapGesture
                        {
                            withAnimation
                            {
                                memoryTheme.emoji.remove(emoji)
                            }
                        }
                }
            }
        }
        
    }
}

//#Preview {
//    ThemeEditor()
//}
