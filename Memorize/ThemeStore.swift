//
//  ThemeStore.swift
//  Memorize
//
//  Created by Wombat on 5/23/25.
//

import Foundation

extension UserDefaults
{
    func memoryThemes(forKey key: String) -> [MemoryTheme]
    {
        if let jsonData = data(forKey: key)
        {
            if let decodedThemes = try? JSONDecoder().decode([MemoryTheme].self, from: jsonData)
            {
                return decodedThemes
            }
            else
            {
                return []
            }
        }
        else
        {
            return []
        }
    }
    
    func set(_ memoryThemes: [MemoryTheme], forKey key: String)
    {
        let data = try? JSONEncoder().encode(memoryThemes)
        set(data, forKey: key)
    }
}

class ThemeStore: ObservableObject, Identifiable
{
    let name: String
    
    var id: String { name }
    
    private var userDefaultsKey: String { "MemoryThemeStore:" + name }
    
    @Published private var _cursorIndex = 0
    
    var memoryThemes: [MemoryTheme]
    {
        get
        {
            UserDefaults.standard.memoryThemes(forKey: userDefaultsKey)
        }
        set
        {
            if (!newValue.isEmpty)
            {
                UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
                objectWillChange.send()
            }
        }
        
    }
    
    init(named name: String)
    {
        self.name = name
        if (memoryThemes.isEmpty)
        {
            memoryThemes = MemoryTheme.builtins
            if (memoryThemes.isEmpty)
            {
                memoryThemes = [MemoryTheme(themeName: "Warning", themeColor: RGBA(color: .red), emoji: ["⚠️"], numberOfPairs: 1)]
            }
        }
    }
    
    var cursorIndex: Int
    {
        get { boundsCheckedPaletteIndex(_cursorIndex) }
        set
        {
            _cursorIndex = boundsCheckedPaletteIndex(newValue)
        }
    }
    
    private func boundsCheckedPaletteIndex(_ index: Int) -> Int
    {
        var index = index % memoryThemes.count
        if (index < 0)
        {
            index+=memoryThemes.count
        }
        return index
    }
    
    // MARK: - Adding Palettes
    func insert(_ memoryTheme: MemoryTheme, at insertionIndex: Int? = nil)
    {
        let insertionIndex = boundsCheckedPaletteIndex(insertionIndex ?? cursorIndex)
        if let index = memoryThemes.firstIndex(where: { $0.id == memoryTheme.id})
        {
            memoryThemes.move(fromOffsets: IndexSet([index]), toOffset: insertionIndex)
            memoryThemes.replaceSubrange(insertionIndex...insertionIndex, with: [memoryTheme])
        }
        else
        {
            memoryThemes.insert(memoryTheme, at: insertionIndex)
        }
    }
    
    func insert(name: String, color: RGBA, emojis: Set<String>, numberOfPairs: Int, at index: Int? = nil)
    {
        insert(MemoryTheme(themeName: name, themeColor: color, emoji: emojis, numberOfPairs: numberOfPairs), at: index)
    }
    
    func append(_ memoryTheme: MemoryTheme)
    {
        if let index = memoryThemes.firstIndex(where: { $0.id == memoryTheme.id })
        {
            if (memoryThemes.count == 1)
            {
                memoryThemes = [memoryTheme]
            }
            else
            {
                memoryThemes.remove(at: index)
                memoryThemes.append(memoryTheme)
            }
        }
        else
        {
            memoryThemes.append(memoryTheme)
        }
    }
    
    func append(name: String, color: RGBA, emojis: Set<String>, numberOfPairs: Int)
    {
        append(MemoryTheme(themeName: name, themeColor: color, emoji: emojis, numberOfPairs: numberOfPairs))
    }
}
