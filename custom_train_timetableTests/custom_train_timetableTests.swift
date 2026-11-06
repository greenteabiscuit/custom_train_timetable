import XCTest
@testable import custom_train_timetable

final class custom_train_timetableTests: XCTestCase {
    func testIchigayaExpressAndHolidayRollover() {
        let weekday = BakuroTimetable.schedule(for: .ichigaya, on: date("2026-11-02 12:00:00"))
        XCTAssertEqual(weekday.map(\.time), ["17:44", "18:10", "18:50", "19:34"])
        XCTAssertTrue(weekday.allSatisfy(\.express))
        let holiday = BakuroTimetable.schedule(for: .ichigaya, on: date("2026-11-03 12:00:00"))
        XCTAssertEqual(holiday.map(\.time), ["16:27", "17:07", "17:45", "18:14", "18:42"])
        XCTAssertEqual(holiday.map(\.destination), ["本八幡", "本八幡", "大島", "大島", "大島"])
        let next = BakuroTimetable.nextDepartures(for: .ichigaya, after: date("2026-11-02 19:34:01"))
        XCTAssertEqual(next.first?.date, date("2026-11-03 16:27:00"))
    }
    private func date(_ string: String) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: string)!
    }

    func testVerifiedNormalSchedulesAndExpressDestinations() {
        let monday = date("2026-11-02 12:00:00")
        let sunday = date("2026-11-01 12:00:00")
        XCTAssertEqual(BakuroTimetable.schedule(for: .bakurocho, on: monday).count, 38)
        XCTAssertEqual(BakuroTimetable.schedule(for: .bakurocho, on: sunday).count, 31)
        let weekday = BakuroTimetable.schedule(for: .bakuroyokoyama, on: monday)
        XCTAssertEqual(weekday.filter { !$0.express }.map(\.time), ["16:30", "17:13", "00:13"])
        XCTAssertEqual(weekday.filter(\.express).map(\.time), ["07:27", "09:19", "09:38", "10:05", "17:34"])
        XCTAssertEqual(weekday.first { $0.time == "09:19" }?.destination, "橋本")
        let holiday = BakuroTimetable.schedule(for: .bakuroyokoyama, on: sunday)
        XCTAssertEqual(holiday.filter { !$0.express }.count, 19)
        XCTAssertEqual(holiday.filter(\.express).map(\.time), ["07:18", "08:24", "09:24", "10:30"])
        XCTAssertEqual(holiday.first { $0.time == "07:18" }?.destination, "京王多摩センター")
    }

    func testNationalSubstituteAndCitizensHolidays() {
        for day in ["2026-11-03", "2026-05-06", "2026-09-22", "2027-03-22"] {
            XCTAssertEqual(BakuroTimetable.dayType(on: date(day + " 12:00:00")), .holiday)
        }
        XCTAssertEqual(BakuroTimetable.dayType(on: date("2026-11-02 12:00:00")), .weekday)
        XCTAssertEqual(BakuroTimetable.schedule(for: .bakuroyokoyama, on: date("2026-11-03 12:00:00")).count, 23)
    }

    func testMidnightKeepsPreviousServiceDayThenChangesToHoliday() {
        let next = BakuroTimetable.nextDepartures(for: .bakuroyokoyama, after: date("2026-11-02 23:59:00"))
        XCTAssertEqual(next[0].date, date("2026-11-03 00:13:00"))
        XCTAssertEqual(next[0].train.day, .weekday)
        XCTAssertEqual(next[1].date, date("2026-11-03 07:10:00"))
        XCTAssertEqual(next[1].train.day, .holiday)
        let afterDeparture = BakuroTimetable.nextDepartures(for: .bakuroyokoyama, after: date("2026-11-03 00:13:01"))
        XCTAssertEqual(afterDeparture[0].date, date("2026-11-03 07:10:00"))
        let jr = BakuroTimetable.nextDepartures(for: .bakurocho, after: date("2026-11-02 23:59:00"))
        XCTAssertEqual(jr.map(\.date), [date("2026-11-03 00:00:00"), date("2026-11-03 00:24:00")])
    }

    func testConstructionDayAppliesOnlyToJRAndRollsOverAtThreeAM() {
        let day = date("2026-11-07 12:00:00")
        XCTAssertEqual(BakuroTimetable.schedule(for: .bakurocho, on: day).count, 115)
        XCTAssertEqual(BakuroTimetable.schedule(for: .bakuroyokoyama, on: day).count, 23)
        let next = BakuroTimetable.nextDepartures(for: .bakurocho, after: date("2026-11-07 00:01:00"))
        XCTAssertEqual(next[0].date, date("2026-11-07 00:24:00"))
        XCTAssertEqual(next[0].train.day, .weekday)
        XCTAssertEqual(next[1].date, date("2026-11-07 05:19:00"))
        XCTAssertEqual(BakuroTimetable.schedule(for: .bakurocho, on: date("2026-11-08 12:00:00")).count, 31)
    }

    func testCountdownRecreatesDatesOnFutureDaysAndDoesNotRepeatDepartedTrains() {
        let next = BakuroTimetable.nextDepartures(for: .bakuroyokoyama, after: date("2026-11-02 07:27:01"))
        XCTAssertEqual(next.map(\.date), [date("2026-11-02 09:19:00"), date("2026-11-02 09:38:00")])
        let later = BakuroTimetable.nextDepartures(for: .bakuroyokoyama, after: date("2026-11-04 17:34:01"))
        XCTAssertEqual(later[0].date, date("2026-11-05 00:13:00"))
        XCTAssertEqual(later[1].date, date("2026-11-05 07:27:00"))
        XCTAssertTrue(BakuroTimetable.nextDepartures(for: .bakurocho, after: .now, count: 0).isEmpty)
    }
    func testAirportExpressSchedulesAndNextDay() {
        let monday = date("2026-11-02 12:00:00")
        let sunday = date("2026-11-08 12:00:00")
        let north = BakuroTimetable.schedule(for: .mitaToHigashinihombashi, on: monday)
        let south = BakuroTimetable.schedule(for: .higashinihombashiToMita, on: sunday)
        XCTAssertEqual(north.count, 14)
        XCTAssertEqual(south.count, 16)
        XCTAssertEqual(north.first?.time, "10:08")
        XCTAssertEqual(north.last?.destination, "宗吾参道")
        XCTAssertEqual(south.first?.time, "06:32")
        XCTAssertTrue(north.allSatisfy { $0.label.contains("エアポート快特") })
        XCTAssertEqual(BakuroTimetable.nextDepartures(for: .higashinihombashiToMita, after: date("2026-11-02 23:00:00")).first?.train.time, "06:32")
    }
}
