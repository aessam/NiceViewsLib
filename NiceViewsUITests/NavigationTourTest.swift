import XCTest

final class NavigationTourTest: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = true
        app.launch()
    }

    func testAppTour() throws {
        let screenshotDir = "/tmp/niceviews_tour"
        try? FileManager.default.createDirectory(atPath: screenshotDir, withIntermediateDirectories: true)

        // 1. Main menu
        sleep(1)
        takeScreenshot(named: "01_main_menu")

        // 2. Components Catalog
        app.staticTexts["Components Catalog"].tap()
        sleep(1)
        takeScreenshot(named: "02_components_catalog")
        app.swipeUp()
        sleep(1)
        takeScreenshot(named: "03_components_catalog_scrolled")
        tapBackIfAvailable()

        // 3. Views Catalog
        app.staticTexts["Views Catalog"].tap()
        sleep(1)
        takeScreenshot(named: "04_views_catalog")
        tapBackIfAvailable()

        // 4. Chat Experience
        app.staticTexts["Chat Experience"].tap()
        sleep(1)
        takeScreenshot(named: "05_chat_experience")
        tapBackIfAvailable()

        // 5. Component Playground
        app.staticTexts["Component Playground"].tap()
        sleep(1)
        takeScreenshot(named: "06_component_playground")
        app.swipeUp()
        sleep(1)
        takeScreenshot(named: "07_component_playground_scrolled")
        tapBackIfAvailable()

        // 6. Animation Showcase
        app.staticTexts["Animation Showcase"].tap()
        sleep(1)
        takeScreenshot(named: "08_animation_showcase")
        app.swipeUp()
        sleep(1)
        takeScreenshot(named: "09_animation_showcase_scrolled")
        tapBackIfAvailable()

        // 7. Component States
        app.staticTexts["Component States"].tap()
        sleep(1)
        takeScreenshot(named: "10_component_states")
        app.swipeUp()
        sleep(1)
        takeScreenshot(named: "11_component_states_scrolled")
        tapBackIfAvailable()

        // 8. Toggle dark mode
        let toggle = app.switches.firstMatch
        if toggle.exists {
            toggle.tap()
            sleep(1)
            takeScreenshot(named: "12_dark_mode_main")

            // 9. Navigate in dark mode
            app.staticTexts["Components Catalog"].tap()
            sleep(1)
            takeScreenshot(named: "13_dark_components_catalog")
            tapBackIfAvailable()

            app.staticTexts["Views Catalog"].tap()
            sleep(1)
            takeScreenshot(named: "14_dark_views_catalog")
            tapBackIfAvailable()

            // Toggle back
            let toggleAgain = app.switches.firstMatch
            if toggleAgain.exists { toggleAgain.tap() }
            sleep(1)
        }

        // 10. Navigate into Views Catalog > Home View
        app.staticTexts["Views Catalog"].tap()
        sleep(1)
        if app.staticTexts["Home View"].exists {
            app.staticTexts["Home View"].tap()
            sleep(1)
            takeScreenshot(named: "15_home_view")
            app.swipeUp()
            sleep(1)
            takeScreenshot(named: "16_home_view_scrolled")
            // Go back to views catalog
            tapMainOrBack()
        }

        if app.staticTexts["Explore View"].exists {
            app.staticTexts["Explore View"].tap()
            sleep(1)
            takeScreenshot(named: "17_explore_view")
            tapMainOrBack()
        }

        if app.staticTexts["Profile View"].exists {
            app.staticTexts["Profile View"].tap()
            sleep(1)
            takeScreenshot(named: "18_profile_view")
            tapMainOrBack()
        }

        if app.staticTexts["Library View"].exists {
            app.staticTexts["Library View"].tap()
            sleep(1)
            takeScreenshot(named: "19_library_view")
            tapMainOrBack()
        }

        takeScreenshot(named: "20_final")
    }

    // MARK: - Helpers

    private func takeScreenshot(named name: String) {
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)

        // Also save to disk for easy access
        let data = screenshot.pngRepresentation
        let path = "/tmp/niceviews_tour/\(name).png"
        try? data.write(to: URL(fileURLWithPath: path))
    }

    private func tapBackIfAvailable() {
        sleep(1)
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        if backButton.exists && backButton.isHittable {
            backButton.tap()
            sleep(1)
            return
        }
        // Try the custom "Back" or "NiceViews" back button
        for label in ["NiceViews", "Back"] {
            let btn = app.buttons[label]
            if btn.exists && btn.isHittable {
                btn.tap()
                sleep(1)
                return
            }
        }
    }

    private func tapMainOrBack() {
        sleep(1)
        // Try "Main" button first (the blue button in top-right)
        let mainButton = app.buttons["Main"]
        if mainButton.exists && mainButton.isHittable {
            mainButton.tap()
            sleep(1)
            return
        }
        tapBackIfAvailable()
    }
}
