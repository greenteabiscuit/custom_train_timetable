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
    var station: StationName


    init(station: StationName) {
        self.station = station
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
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Station"
    static var defaultQuery = StationQuery()
            
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(avatar) \(id)")
    }


    static let allStations: [StationName] = [
        StationName(id: "東十条", avatar: "🐼", healthLevel: 0.14, heroType: "南浦和"),
        StationName(id: "王子神谷", avatar: "🦄", healthLevel: 0.67, heroType: "赤羽岩淵"),
        StationName(id: "赤羽", avatar: "🐳", healthLevel: 0.83, heroType: "南浦和")
    ]
}

struct StationQuery: EntityQuery {
    func entities(for identifiers: [StationName.ID]) async throws -> [StationName] {
        StationName.allStations.filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [StationName] {
        StationName.allStations.filter { $0.isAvailable }
    }
    
    func defaultResult() async -> StationName? {
        try? await suggestedEntities().first
    }
}
