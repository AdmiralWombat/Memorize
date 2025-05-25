//
//  MemoryTheme.swift
//  Memorize
//
//  Created by Wombat on 5/1/25.
//

import Foundation

struct MemoryTheme: Identifiable, Codable, Hashable
{
    var themeName : String
    var themeColor : RGBA
    var emoji : Set<String>
    var numberOfPairs : Int
    
    var id = UUID()
    

    static var builtins: [MemoryTheme]
    {
        [
            MemoryTheme(themeName: "Halloween", themeColor: RGBA(color: .orange), emoji: halloweenEmojis, numberOfPairs: 7),
            MemoryTheme(themeName: "Farm", themeColor: RGBA(color: .green), emoji: farmEmojis, numberOfPairs: 6),
            MemoryTheme(themeName: "Sports", themeColor: RGBA(color: .black), emoji: sportsEmojis, numberOfPairs: 8),
            MemoryTheme(themeName: "Faces", themeColor: RGBA(color: .yellow), emoji: faceEmojis, numberOfPairs: 8),
            MemoryTheme(themeName: "Animals", themeColor: RGBA(color: .purple), emoji: animalEmojis, numberOfPairs: 9),
            MemoryTheme(themeName: "Food", themeColor: RGBA(color: .blue), emoji: foodEmojis, numberOfPairs: 11)
        ]
    }
}

private let halloweenEmojis: Set<String> = Set("👻🕷️🎃😈💀🕸️🧙‍♀️🙀👹😱☠️🍭".map{String($0)})
private let farmEmojis: Set<String> = Set("🐖🐐🐰🐴🐓🦃🚜🐑🐄🧑‍🌾🫏".map{String($0)})
private let sportsEmojis: Set<String> = Set("⚽️🏈🏀⚾️🎾🏐🏓🏸🏒🥊".map{String($0)})
private let faceEmojis: Set<String> = Set("😂☺️😘😳😭😃🥸😎🥳🤪".map{String($0)})
private let animalEmojis: Set<String> = Set("🐍🐢🐸🙉🦋🐞🦇🦩🐼🐻🐝".map{String($0)})
private let foodEmojis: Set<String> = Set("🍔🌭🌮🍕🍟🍿🍩🍤🍦🍝🍌".map{String($0)})

