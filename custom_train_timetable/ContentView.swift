//
//  ContentView.swift
//  custom_train_timetable
//
//  Created by lvcha mmm on 2024/01/03.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @AppStorage("bakuroRoute") private var routeName = BakuroRoute.bakuroyokoyama.rawValue
    @State private var selection = BakuroDaySelection.automatic
    private var route: BakuroRoute { BakuroRoute(rawValue: routeName) ?? .bakuroyokoyama }

    var body: some View {
        NavigationStack {
            TimelineView(.periodic(from: .now, by: 60)) { context in
                timetable(at: context.date)
            }
            .navigationTitle("時刻表")
        }
        .onOpenURL { url in
            if let selected = BakuroRoute.allCases.first(where: { $0.path == url.lastPathComponent }) { routeName = selected.rawValue }
        }
        .task { WidgetCenter.shared.reloadAllTimelines() }
    }

    private func timetable(at now: Date) -> some View {
        let day = BakuroTimetable.serviceDay(at: now)
        let rows = BakuroTimetable.schedule(for: route, on: day, selection: selection)
        return List {
            Section {
                Picker("駅", selection: $routeName) {
                    ForEach(BakuroRoute.allCases) { Text($0.rawValue).tag($0.rawValue) }
                }
                .pickerStyle(.menu)
                .accessibilityIdentifier("station-picker")
                Label("\(route.line) · \(route.summary)", systemImage: "tram.fill")
                    .font(.subheadline).foregroundStyle(.secondary)
            }
            Section("ウィジェット") {
                BakuroWidgetContent(route: route,
                    departures: BakuroTimetable.nextDepartures(for: route, after: now, count: 3), compact: false)
                    .padding(12).frame(height: 160)
                    .background { BakuroWidgetBackground().clipShape(RoundedRectangle(cornerRadius: 20)) }
                    .environment(\.colorScheme, .dark)
                Text("ホーム画面でウィジェットを追加し、長押し →「ウィジェットを編集」→ 駅を選択。市ヶ谷・馬喰町・馬喰横山を選べます。")
                    .font(.footnote).foregroundStyle(.secondary)
            }
            Section {
                Picker("ダイヤ", selection: $selection) {
                    ForEach(BakuroDaySelection.allCases) { Text($0.rawValue).tag($0) }
                }.pickerStyle(.segmented)
                if selection == .automatic && BakuroTimetable.isConstructionDay(day, route: route) {
                    Text("11月7日は工事のため東京折返し").font(.footnote).foregroundStyle(.orange)
                }
                ForEach(rows) { train in
                    HStack(spacing: 16) {
                        Text(train.serviceTime).font(.title3.monospacedDigit()).frame(width: 82, alignment: .leading)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(train.label).fontWeight(train.express ? .semibold : .regular)
                            if !train.note.isEmpty { Text(train.note).font(.caption).foregroundStyle(.secondary) }
                        }
                    }
                    .accessibilityIdentifier("train-\(train.minute)-\(train.express ? "express" : "terminating")")
                }
            } header: {
                Text("全時刻表 · \(rows.first?.day.rawValue ?? "") · \(rows.count)本")
            }
            Section {
                Text("時刻表は2026年11月確認。祝日情報は2027年まで。0時台は前日のダイヤです。")
                    .font(.footnote).foregroundStyle(.secondary)
                Link("公式時刻表", destination: BakuroTimetable.sourceURL(for: route,
                    day: rows.first?.day ?? .weekday))
            }
        }
        .tint(route.color)
    }
}

#Preview {
    ContentView()
}
