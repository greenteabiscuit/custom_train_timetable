import XCTest

final class custom_train_timetableUITests: XCTestCase {
    func testNewStationsWidgetPreviewAndWeekdayTimetables() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
        let stations = app.buttons["station-picker"]
        XCTAssertTrue(stations.waitForExistence(timeout: 10))
        stations.tap()
        app.buttons["馬喰横山"].tap()
        XCTAssertTrue(app.otherElements.containing(.staticText, identifier: "都営新宿線").firstMatch.exists
                      || app.staticTexts.containing(NSPredicate(format: "label CONTAINS %@", "都営新宿線")).firstMatch.exists)
        app.segmentedControls.buttons["平日"].tap()
        XCTAssertTrue(app.staticTexts["全時刻表 · 平日 · 8本"].exists)
        let widgetScreenshot = XCTAttachment(screenshot: app.screenshot())
        widgetScreenshot.name = "馬喰横山-左右2列ウィジェット"
        widgetScreenshot.lifetime = .keepAlways
        add(widgetScreenshot)
        app.swipeUp()
        XCTAssertTrue(app.staticTexts["急行 笹塚行き"].firstMatch.exists)
        let screenshot = XCTAttachment(screenshot: app.screenshot())
        screenshot.name = "馬喰横山-新宿止まりと急行"
        screenshot.lifetime = .keepAlways
        add(screenshot)

        app.swipeDown()
        app.swipeDown()
        stations.tap()
        app.buttons["馬喰町"].tap()
        XCTAssertTrue(app.staticTexts.containing(NSPredicate(format: "label CONTAINS %@", "総武快速線")).firstMatch.exists)
        XCTAssertTrue(app.staticTexts["全時刻表 · 平日 · 38本"].exists)
        app.segmentedControls.buttons["土休日"].tap()
        XCTAssertTrue(app.staticTexts["全時刻表 · 土休日 · 31本"].exists)
        let jrScreenshot = XCTAttachment(screenshot: app.screenshot())
        jrScreenshot.name = "馬喰町-ウィジェットと東京止まり"
        jrScreenshot.lifetime = .keepAlways
        add(jrScreenshot)
    }
}
