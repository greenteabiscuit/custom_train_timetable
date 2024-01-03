//
//  AppIntent.swift
//  widget
//
//  Created by lvcha mmm on 2024/01/03.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Select Character"
    static var description = IntentDescription("Selects the character to display information for.")


    @Parameter(title: "Character")
    var character: StationName


    init(character: StationName) {
        self.character = character
    }


    init() {
    }
}

struct StationName: AppEntity {
    let id: String
    let avatar: String
    let healthLevel: Double
    let heroType: String
    let isAvailable = true
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Character"
    static var defaultQuery = CharacterQuery()
            
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(avatar) \(id)")
    }


    static let allCharacters: [StationName] = [
        StationName(id: "Power Panda", avatar: "🐼", healthLevel: 0.14, heroType: "Forest Dweller"),
        StationName(id: "Unipony", avatar: "🦄", healthLevel: 0.67, heroType: "Free Rangers"),
        StationName(id: "Spouty", avatar: "🐳", healthLevel: 0.83, heroType: "Deep Sea Goer")
    ]
}

struct CharacterQuery: EntityQuery {
    func entities(for identifiers: [StationName.ID]) async throws -> [StationName] {
        StationName.allCharacters.filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [StationName] {
        StationName.allCharacters.filter { $0.isAvailable }
    }
    
    func defaultResult() async -> StationName? {
        try? await suggestedEntities().first
    }
}
