//
//  custom_train_timetable_widget.swift
//  custom_train_timetable_widget
//
//  Created by lvcha mmm on 2024/01/03.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    static var weekdaySchedule: [TimePoint] = [
        TimePoint(hour: 10, min: 41, origin: "東十条", dest: "蒲田"),
        TimePoint(hour: 10, min: 56, origin: "東十条", dest: "蒲田"),
        TimePoint(hour: 11, min: 11, origin: "東十条", dest: "蒲田"),
        TimePoint(hour: 11, min: 31, origin: "東十条", dest: "蒲田"),
        TimePoint(hour: 23, min: 23, origin: "東十条", dest: "蒲田"),
    ]

    static var weekendSchedule: [TimePoint] = [
        TimePoint(hour: 23, min: 31, origin: "東十条", dest: "武蔵小杉"),
    ]
    
    // Define the class with two Int fields: hour and min
    class TimePoint {
        var hour: Int
        var min: Int
        var date: Date
        var origin: String
        var dest: String
        
        init(hour: Int, min: Int, origin: String, dest: String) {
            let today = Calendar.current.startOfDay(for: Date())
            self.hour = hour
            self.min = min
            self.date = Calendar.current.date(bySettingHour: hour, minute: min, second: 0, of: today)!
            self.dest = dest
            self.origin = origin
        }
    }
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), id: "bad", origin: "nowhere")
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, id: "bad", origin: "nowhere")
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let currentDate = Date()
        let seconds = Calendar.current.component(.second, from: currentDate)
        let startDate = Calendar.current.date(byAdding: .second, value: -seconds, to: currentDate)!
        let entries = (0 ..< 60).map {
            let date = Calendar.current.date(byAdding: .second, value: $0 * 60 - 1, to: startDate)!
            let otherDate = Calendar.current.date(byAdding: .second, value: $0 * 60, to: startDate)!
            let (first, second) = getNextSchedule(now: otherDate)
            return SimpleEntry(date: date, configuration: configuration, id: configuration.station.id, closestDate: first, secondClosestDate: second, origin: configuration.station.origin)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
    
    // func name: getNextSchedule
    // input: None
    // output: Date?, Date?
    // description:
    // 1. Get the current time
    // 2. Get the current weekday
    // 3. Get the current hour
    // 4. Get the current minute
    // 5. Call isWeekend by passing the current time
    // 6. if result is true, enumerate through the weekendSchedule array until
    // the difference between the current time and the time in the array is the least
    // and the current time is still before the time in the array
    // 7. if result is false, enumerate through the weekdaySchedule array until
    // the difference between the current time and the time in the array is the least
    // and the current time is still before the time in the array
    // 8. return the time in the array and the time in the array after that
    // if the time in the array is the last one, return nil for the second return value
    // 9. If there is none, return nil
    func getNextSchedule(now: Date) -> (Date?, Date?) {
        let calendar = Calendar.current
        
        // Get the current hour and minute
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        
        // Get the current weekday
        let components = calendar.dateComponents([.weekday], from: now)
        
        if let weekday = components.weekday {
            // Sunday = 1, Saturday = 7, Weekdays = 2-6
            if weekday == 1 || weekday == 7 {
                // for weekend!
                let weekendSchedule = Provider.weekendSchedule
                for (index, condition) in weekendSchedule.enumerated() {
                    if (hour < condition.hour) || (hour == condition.hour && minute < condition.min) {
                        if (index + 1 == weekendSchedule.count) {
                            return (condition.date, nil)
                        }
                        return (condition.date, weekendSchedule[index + 1].date)
                    }
                }
            } else {
                // for weekday
                let weekdaySchedule = Provider.weekdaySchedule
                
                for (index, condition) in weekdaySchedule.enumerated() {
                    if (hour < condition.hour) || (hour == condition.hour && minute < condition.min) {
                        if (index + 1 == weekdaySchedule.count) {
                            return (condition.date, nil)
                        }
                        return (condition.date, weekdaySchedule[index + 1].date)
                    }
                }
            }
        }
        return (nil, nil)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let id: String
    var closestDate: Date? = .now
    var secondClosestDate: Date? = .now
    let origin: String
}

struct custom_train_timetable_widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                contentView
                Spacer()
            }
            VStack(alignment: .leading) {
                Text("次のダイヤ")
                    .foregroundColor(.gray)
                if entry.secondClosestDate != nil {
                    Text("\(entry.secondClosestDate!, formatter: Self.dateFormatter)")
                    .foregroundColor(.gray)
                } else {
                    Text("本日は終了しました")
                    .foregroundColor(.gray)
                }
                    
            }
        }
        .containerBackground(.clear, for: .widget)
    }
    
    @ViewBuilder
    private var contentView: some View {
        HStack {
            Circle()
                .fill(Color.green)
                .frame(width: 10, height: 10)
            Text("\(entry.id)\n\(entry.origin)発")
                .font(.system(size: 15))
            if entry.closestDate != nil {
                Text("\(entry.closestDate!, formatter: Self.dateFormatter)")
            } else {
                Text("本日は終了しました")
            }
        }
        if entry.closestDate != nil {
            Text(entry.closestDate!, style: .timer)
                .font(.system(size: 30))
        }
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "en_US_POSIX")
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}

struct custom_train_timetable_widget: Widget {
    let kind: String = "custom_train_timetable_widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            custom_train_timetable_widgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent(station: StationName(id: "default", avatar: "🐼", healthLevel: 0.77, origin: "something"))
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent(station: StationName(id: "default", avatar: "🐼", healthLevel: 0.77, origin: "something"))
        return intent
    }
}

#Preview(as: .systemSmall) {
    custom_train_timetable_widget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, id: "bad", origin: "nowhere")
    SimpleEntry(date: .now, configuration: .starEyes, id: "bad", origin: "nowhere")
}


