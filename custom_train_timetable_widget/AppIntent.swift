//
//  AppIntent.swift
//  widget
//
//  Created by lvcha mmm on 2024/01/03.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Select Station"
    static var description = IntentDescription("Selects the station to display information for.")


    @Parameter(title: "station")
    var station: StationName?

    var selectedStation: StationName { station ?? StationName.allStations[0] }


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
    let origin: String
    let isAvailable = true
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Station"
    static var defaultQuery = StationQuery()
            
    var displayRepresentation: DisplayRepresentation {
        if let route = BakuroRoute(rawValue: id) {
            return DisplayRepresentation(title: "\(id) · \(route.summary)", subtitle: "\(route.line)")
        }
        return DisplayRepresentation(title: "\(avatar) \(id)")
    }


    static let allStations: [StationName] = [
        StationName(id: "東十条", avatar: "🐼", healthLevel: 0.14, origin: "南浦和"),
        StationName(id: "王子神谷", avatar: "🦄", healthLevel: 0.67, origin: "赤羽岩淵"),
        StationName(id: "代々木上原", avatar: "🐳", healthLevel: 0.83, origin: "代々木上原"),
        StationName(id: "市ヶ谷", avatar: "S", healthLevel: 0, origin: "市ヶ谷"),
        StationName(id: "馬喰町", avatar: "JO", healthLevel: 0, origin: "馬喰町"),
        StationName(id: "馬喰横山", avatar: "S", healthLevel: 0, origin: "馬喰横山"),
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
