import Foundation
import SwiftUI

enum BakuroRoute: String, CaseIterable, Identifiable {
    case bakurocho = "馬喰町"
    case bakuroyokoyama = "馬喰横山"
    case ichigaya = "市ヶ谷"

    var id: String { rawValue }
    var summary: String { self == .bakurocho ? "東京止まり" : (self == .ichigaya ? "本八幡方面・急行" : "新宿止まり・急行") }
    var line: String { self == .bakurocho ? "総武快速線" : "都営新宿線" }
    var code: String { self == .bakurocho ? "JO" : "S" }
    // Passenger-information line colors: JR Yokosuka/Sobu Rapid and Toei Shinjuku.
    var color: Color {
        self == .bakurocho
            ? Color(red: 0x00 / 255.0, green: 0x7A / 255.0, blue: 0xC0 / 255.0)
            : Color(red: 0xB0 / 255.0, green: 0xBF / 255.0, blue: 0x1E / 255.0)
    }
}

enum BakuroDay: String { case weekday = "平日", holiday = "土休日" }
enum BakuroDaySelection: String, CaseIterable, Identifiable {
    case automatic = "自動", weekday = "平日", holiday = "土休日"
    var id: String { rawValue }
}

struct BakuroTrain: Hashable, Identifiable {
    let route: BakuroRoute
    let day: BakuroDay
    /// Minutes from the start of the service day; 00:13 is 1453, not 13.
    let minute: Int
    let destination: String
    var express = false
    var note = ""
    var id: String { "\(route.rawValue)-\(day.rawValue)-\(minute)-\(destination)-\(express)" }
    var label: String { express ? "急行 \(destination)行き" : "\(destination)止まり" }
    var time: String { String(format: "%02d:%02d", minute / 60 % 24, minute % 60) }
    var serviceTime: String { (minute >= 1440 ? "翌 " : "") + time }
}

struct BakuroDeparture: Identifiable {
    let train: BakuroTrain
    let date: Date
    var id: String { "\(train.id)-\(date.timeIntervalSince1970)" }
}

enum BakuroTimetable {
    static var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        return calendar
    }

    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.timeZone = calendar.timeZone
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    static func dateKey(_ date: Date) -> String {
        let c = calendar.dateComponents([.year, .month, .day], from: date)
        return String(format: "%04d-%02d-%02d", c.year!, c.month!, c.day!)
    }

    static func serviceDay(at date: Date) -> Date {
        let start = calendar.startOfDay(for: date)
        return calendar.component(.hour, from: date) < 3
            ? calendar.date(byAdding: .day, value: -1, to: start)! : start
    }

    static func dayType(on serviceDay: Date) -> BakuroDay {
        let weekday = calendar.component(.weekday, from: serviceDay)
        return weekday == 1 || weekday == 7 || holidays.contains(dateKey(serviceDay)) ? .holiday : .weekday
    }

    static func isConstructionDay(_ day: Date, route: BakuroRoute) -> Bool {
        route == .bakurocho && dateKey(day) == "2026-11-07"
    }

    static func schedule(for route: BakuroRoute, on day: Date,
                         selection: BakuroDaySelection = .automatic) -> [BakuroTrain] {
        if selection == .automatic && isConstructionDay(day, route: route) {
            return construction.sorted { $0.minute < $1.minute }
        }
        let type: BakuroDay
        switch selection {
        case .automatic: type = dayType(on: day)
        case .weekday: type = .weekday
        case .holiday: type = .holiday
        }
        return normal.filter { $0.route == route && $0.day == type }.sorted { $0.minute < $1.minute }
    }

    static func nextDepartures(for route: BakuroRoute, after now: Date, count: Int = 2) -> [BakuroDeparture] {
        let firstDay = serviceDay(at: now)
        return (0..<3).flatMap { offset -> [BakuroDeparture] in
            let day = calendar.date(byAdding: .day, value: offset, to: firstDay)!
            return schedule(for: route, on: day).map {
                BakuroDeparture(train: $0, date: calendar.date(byAdding: .minute, value: $0.minute, to: day)!)
            }
        }.filter { $0.date >= now }.sorted { $0.date < $1.date }.prefix(max(0, count)).map { $0 }
    }

    static func sourceURL(for route: BakuroRoute, day: BakuroDay) -> URL {
        if route == .bakurocho {
            return URL(string: "https://timetables.jreast.co.jp/2611/timetable/tt1220/122002\(day == .weekday ? 0 : 1).html")!
        }
        if route == .ichigaya {
            return URL(string: "https://www.kotsu.metro.tokyo.jp/subway/timetable/shinjuku/S04E\(day == .weekday ? "D" : "H").html")!
        }
        return URL(string: "https://www.kotsu.metro.tokyo.jp/subway/timetable/shinjuku/S09W\(day == .weekday ? "D" : "H").html")!
    }

    // BEGIN VERIFIED DATA — official timetables checked 2026-11-02.
    static let normal: [BakuroTrain] = [
        BakuroTrain(route: .ichigaya, day: .weekday, minute: 1064, destination: "本八幡", express: true),
        BakuroTrain(route: .ichigaya, day: .weekday, minute: 1090, destination: "本八幡", express: true),
        BakuroTrain(route: .ichigaya, day: .weekday, minute: 1130, destination: "本八幡", express: true),
        BakuroTrain(route: .ichigaya, day: .weekday, minute: 1174, destination: "本八幡", express: true),
        BakuroTrain(route: .ichigaya, day: .holiday, minute: 987, destination: "本八幡", express: true),
        BakuroTrain(route: .ichigaya, day: .holiday, minute: 1027, destination: "本八幡", express: true),
        BakuroTrain(route: .ichigaya, day: .holiday, minute: 1065, destination: "大島", express: true),
        BakuroTrain(route: .ichigaya, day: .holiday, minute: 1094, destination: "大島", express: true),
        BakuroTrain(route: .ichigaya, day: .holiday, minute: 1122, destination: "大島", express: true),
        BakuroTrain(route: .bakuroyokoyama, day: .weekday, minute: 990, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .weekday, minute: 1033, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .weekday, minute: 1453, destination: "新宿", express: false, note: "新宿で京王新線に連絡"),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 430, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 481, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 521, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 550, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 675, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 707, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 735, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 767, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 795, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 827, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 855, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 876, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 898, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 915, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 936, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 969, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 991, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 1099, destination: "新宿", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 1453, destination: "新宿", express: false, note: "新宿で京王新線に連絡"),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 416, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 423, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 445, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 454, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 464, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 481, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 490, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 505, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 514, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 530, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 550, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 610, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 637, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 696, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 756, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 816, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 877, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 937, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 991, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1012, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1022, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1032, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1073, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1105, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1136, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1146, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1179, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1194, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1216, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1225, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1251, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1303, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1318, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1351, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1387, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1416, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1440, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .weekday, minute: 1464, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 419, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 445, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 456, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 479, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 512, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 524, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 541, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 609, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 638, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 653, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 687, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 696, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 756, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 817, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 877, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 923, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 937, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 991, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1012, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1041, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1058, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1105, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1137, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1145, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1195, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1202, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1216, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1279, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1416, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1440, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1464, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakuroyokoyama, day: .weekday, minute: 447, destination: "笹塚", express: true, note: "神保町で各駅停車に連絡"),
        BakuroTrain(route: .bakuroyokoyama, day: .weekday, minute: 559, destination: "橋本", express: true, note: "神保町で各駅停車に連絡／女性専用車あり"),
        BakuroTrain(route: .bakuroyokoyama, day: .weekday, minute: 578, destination: "笹塚", express: true, note: "神保町で各駅停車に連絡"),
        BakuroTrain(route: .bakuroyokoyama, day: .weekday, minute: 605, destination: "笹塚", express: true, note: "神保町で各駅停車に連絡"),
        BakuroTrain(route: .bakuroyokoyama, day: .weekday, minute: 1054, destination: "笹塚", express: true, note: "神保町で各駅停車に連絡"),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 438, destination: "京王多摩センター", express: true, note: "神保町で各駅停車に連絡"),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 504, destination: "橋本", express: true, note: "神保町で各駅停車に連絡"),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 564, destination: "京王多摩センター", express: true, note: "神保町で各駅停車に連絡"),
        BakuroTrain(route: .bakuroyokoyama, day: .holiday, minute: 630, destination: "京王多摩センター", express: true, note: "神保町で各駅停車に連絡"),
    ]

    static let construction: [BakuroTrain] = [
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 319, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 340, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 371, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 387, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 407, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 419, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 428, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 438, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 445, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 451, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 456, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 464, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 468, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 474, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 479, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 484, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 489, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 496, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 501, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 506, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 512, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 519, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 524, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 532, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 541, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 550, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 562, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 574, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 585, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 598, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 603, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 609, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 620, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 629, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 638, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 648, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 653, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 663, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 678, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 687, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 692, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 696, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 708, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 720, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 738, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 747, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 756, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 768, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 780, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 798, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 807, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 817, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 829, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 840, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 858, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 867, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 877, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 888, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 900, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 918, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 923, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 927, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 937, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 949, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 960, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 978, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 986, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 992, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 996, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1008, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1012, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1016, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1028, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1041, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1051, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1058, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1068, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1077, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1082, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1090, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1101, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1105, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1117, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1130, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1137, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1145, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1151, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1162, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1171, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1177, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1189, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1195, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1202, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1207, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1216, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1224, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1240, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1252, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1261, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1272, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1279, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1289, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1295, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1310, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1320, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1331, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1345, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1361, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1376, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1394, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1408, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1416, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1425, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1440, destination: "東京", express: false, note: ""),
        BakuroTrain(route: .bakurocho, day: .holiday, minute: 1464, destination: "東京", express: false, note: ""),
    ]

    // Cabinet Office holidays (including substitute/citizens holidays), 2026–2027.
    // https://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv
    static let holidays: Set<String> = [
        "2026-01-01",
        "2026-01-12",
        "2026-02-11",
        "2026-02-23",
        "2026-03-20",
        "2026-04-29",
        "2026-05-03",
        "2026-05-04",
        "2026-05-05",
        "2026-05-06",
        "2026-07-20",
        "2026-08-11",
        "2026-09-21",
        "2026-09-22",
        "2026-09-23",
        "2026-10-12",
        "2026-11-03",
        "2026-11-23",
        "2027-01-01",
        "2027-01-11",
        "2027-02-11",
        "2027-02-23",
        "2027-03-21",
        "2027-03-22",
        "2027-04-29",
        "2027-05-03",
        "2027-05-04",
        "2027-05-05",
        "2027-07-19",
        "2027-08-11",
        "2027-09-20",
        "2027-09-23",
        "2027-10-11",
        "2027-11-03",
        "2027-11-23"
    ]
    // END VERIFIED DATA
}

/// Shared by the actual widget and its in-app preview.
struct BakuroWidgetBackground: View {
    var body: some View {
        LinearGradient(colors: [Color(white: 0.11), .black],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct BakuroWidgetContent: View {
    let route: BakuroRoute
    let departures: [BakuroDeparture]
    var compact = true

    var body: some View {
        Group {
            if compact {
                compactContent
            } else {
                HStack(alignment: .top, spacing: 14) {
                    primaryContent
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    upcomingContent
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
        }
        .foregroundStyle(.primary)
    }

    private var stationHeader: some View {
        HStack(spacing: 7) {
            RoundedRectangle(cornerRadius: 2).fill(route.color).frame(width: 4)
            VStack(alignment: .leading, spacing: 1) {
                Text(route.line)
                    .font(.system(size: 10, weight: .semibold)).foregroundStyle(.secondary)
                Text(route.rawValue).font(.system(size: 17, weight: .bold))
            }
            .lineLimit(1).minimumScaleFactor(0.8)
        }
        .fixedSize(horizontal: false, vertical: true)
        .accessibilityElement(children: .combine)
    }

    private var primaryContent: some View {
        VStack(alignment: .leading, spacing: 7) {
            stationHeader
            if let next = departures.first {
                trainSummary(next, primary: true)
                Spacer(minLength: 0)
                Text(next.date, style: .timer)
                    .font(.system(size: 38, weight: .heavy, design: .rounded))
                    .monospacedDigit().lineLimit(1).minimumScaleFactor(0.65)
                    .accessibilityLabel("発車まで")
                    .accessibilityIdentifier("widget-countdown")
            } else {
                Text("対象列車なし").font(.subheadline)
                Spacer(minLength: 0)
            }
        }
    }

    private var upcomingContent: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("次のダイヤ")
                .font(.system(size: 11, weight: .semibold)).foregroundStyle(.secondary)
            Divider().overlay(Color.secondary.opacity(0.2))
            ForEach(Array(departures.dropFirst().prefix(2))) { departure in
                trainSummary(departure, primary: false)
                if departure.id != departures.dropFirst().prefix(2).last?.id {
                    Divider().overlay(Color.secondary.opacity(0.2))
                }
            }
            if departures.count < 2 {
                Text("なし").font(.caption).foregroundStyle(.secondary)
            }
        }
    }

    private func trainSummary(_ departure: BakuroDeparture, primary: Bool) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack(alignment: .firstTextBaseline, spacing: 5) {
                Text(departure.date, formatter: BakuroTimetable.timeFormatter)
                    .font(.system(size: primary ? 16 : 15, weight: .bold, design: .rounded))
                    .monospacedDigit().fixedSize()
                // A shared destination is already shown beside the first departure.
                if primary || departure.train.destination != departures.first?.train.destination {
                    Text(primary && !departure.train.express
                         ? "\(departure.train.destination)止まり" : "\(departure.train.destination)行")
                        .font(.system(size: 12, weight: .semibold))
                        .lineLimit(1).truncationMode(.tail)
                }
            }
            .foregroundStyle(primary ? .primary : .secondary)
            HStack(spacing: 4) {
                badge(departure.train.express ? "急行" : route == .bakurocho ? "快速" : "各停",
                      color: departure.train.express ? Color(red: 0.48, green: 0.48, blue: 1) : .primary)
                badge(departure.train.day.rawValue, color: .secondary)
            }
        }
    }

    private func badge(_ title: String, color: Color) -> some View {
        Text(title).font(.system(size: 10, weight: .bold))
            .foregroundStyle(color).padding(.horizontal, 4).padding(.vertical, 2)
            .overlay(RoundedRectangle(cornerRadius: 4).strokeBorder(color.opacity(0.8), lineWidth: 1))
            .fixedSize()
    }

    private var compactContent: some View {
        VStack(alignment: .leading, spacing: 6) {
            stationHeader
            if let next = departures.first {
                trainSummary(next, primary: true)
                Text(next.date, style: .timer)
                    .font(.system(size: 29, weight: .heavy, design: .rounded))
                    .monospacedDigit().lineLimit(1).minimumScaleFactor(0.65)
                if let second = departures.dropFirst().first {
                    HStack(spacing: 4) {
                        Text("次")
                        Text(second.date, formatter: BakuroTimetable.timeFormatter).monospacedDigit()
                    }.font(.caption2).foregroundStyle(.secondary)
                }
            } else {
                Text("対象列車なし").font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
