import XCTest

final class FullNavigationTourTest: XCTestCase {

    let app = XCUIApplication()
    let outputDir = "/tmp/niceviews_full_tour"
    var hotspots: [String: [[String: Any]]] = [:]

    override func setUpWithError() throws {
        continueAfterFailure = true
        try? FileManager.default.createDirectory(atPath: outputDir, withIntermediateDirectories: true)
        app.launch()
        sleep(1)
    }

    override func tearDownWithError() throws {
        // Write hotspots JSON
        let jsonData = try JSONSerialization.data(withJSONObject: hotspots, options: [.prettyPrinted, .sortedKeys])
        try jsonData.write(to: URL(fileURLWithPath: "\(outputDir)/hotspots.json"))
    }

    func testFullNavigationTour() throws {
        // ── 1. Main Menu ──
        capture("main_menu")
        captureHotspots("main_menu", labels: [
            "Components Catalog", "Views Catalog",
            "Chat Experience", "Component Playground",
            "Animation Showcase", "Component States"
        ])

        // ── 2. Components Catalog ──
        tap("Components Catalog")
        capture("components_catalog")

        let componentDemos = [
            ("Media Card Styles", "comp_media_card"),
            ("List Item Styles", "comp_list_item"),
            ("Bottom Tab Bar", "comp_bottom_tab_bar"),
            ("Tab Selector", "comp_tab_selector"),
            ("Hero Section", "comp_hero_section"),
            ("Search Bar", "comp_search_bar"),
            ("User Avatar", "comp_user_avatar"),
            ("Status Badges", "comp_status_badges"),
            ("Action Buttons", "comp_action_buttons"),
            ("Icon Buttons", "comp_icon_buttons"),
            ("Section Headers", "comp_section_headers"),
            ("Horizontal Scroll", "comp_horizontal_scroll"),
        ]

        captureHotspots("components_catalog", labels: componentDemos.map { $0.0 })

        for (label, screenId) in componentDemos {
            if scrollToAndTap(label) {
                sleep(1)
                capture(screenId)
                app.swipeUp()
                sleep(1)
                capture("\(screenId)_scrolled")
                goBack()
                sleep(1)
            }
        }

        // Return to main menu
        goBack()

        // ── 3. Views Catalog ──
        tap("Views Catalog")
        capture("views_catalog")

        let viewSamples = [
            ("Home View", "view_home"),
            ("Home View Alternative", "view_home_alt"),
            ("Pin Home View", "view_pin_home"),
            ("Explore View", "view_explore"),
            ("Explore View Alternative", "view_explore_alt"),
            ("Library View", "view_library"),
            ("Profile View", "view_profile"),
            ("Album Details View", "view_album_details"),
            ("Video Player View", "view_video_player"),
            ("Search Results View", "view_search_results"),
            ("For You View", "view_for_you"),
            ("Trailer View", "view_trailer"),
        ]

        captureHotspots("views_catalog", labels: viewSamples.map { $0.0 })
        // Return to main menu before iterating views
        goBack()

        // Each view is visited fresh: Main Menu → Views Catalog → View → back to Main Menu
        for (label, screenId) in viewSamples {
            captureViewFromCatalog(label: label, screenId: screenId)
        }

        // ── 4. Chat Experience ──
        tap("Chat Experience")
        capture("chat_experience")
        goBack()

        // ── 5. Component Playground ──
        tap("Component Playground")
        capture("component_playground")
        app.swipeUp()
        sleep(1)
        capture("component_playground_scrolled")
        goBack()

        // ── 6. Animation Showcase ──
        tap("Animation Showcase")
        capture("animation_showcase")
        app.swipeUp()
        sleep(1)
        capture("animation_showcase_scrolled")
        goBack()

        // ── 7. Component States ──
        tap("Component States")
        capture("component_states")
        app.swipeUp()
        sleep(1)
        capture("component_states_scrolled")
        app.swipeUp()
        sleep(1)
        capture("component_states_scrolled2")
        goBack()

        // Final main menu
        capture("main_menu_final")
    }

    // MARK: - Helpers

    private func capture(_ name: String) {
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
        let data = screenshot.pngRepresentation
        try? data.write(to: URL(fileURLWithPath: "\(outputDir)/\(name).png"))
    }

    private func captureHotspots(_ screenId: String, labels: [String]) {
        var spots: [[String: Any]] = []
        var remaining = Set(labels)

        // First pass: capture visible elements
        for label in labels {
            let element = app.staticTexts[label]
            if element.exists {
                let frame = element.frame
                spots.append([
                    "label": label,
                    "x": frame.origin.x,
                    "y": frame.origin.y,
                    "w": frame.size.width,
                    "h": frame.size.height
                ])
                remaining.remove(label)
            }
        }

        // Scroll and capture remaining elements
        if !remaining.isEmpty {
            for _ in 0..<6 {
                app.swipeUp()
                usleep(500_000)
                for label in Array(remaining) {
                    let element = app.staticTexts[label]
                    if element.exists {
                        let frame = element.frame
                        spots.append([
                            "label": label,
                            "x": frame.origin.x,
                            "y": frame.origin.y,
                            "w": frame.size.width,
                            "h": frame.size.height
                        ])
                        remaining.remove(label)
                    }
                }
                if remaining.isEmpty { break }
            }
            // Scroll back to top
            for _ in 0..<6 { app.swipeDown(); usleep(300_000) }
            sleep(1)
        }

        hotspots[screenId] = spots
    }

    private func tap(_ label: String) {
        let element = app.staticTexts[label]
        if element.waitForExistence(timeout: 3) && element.isHittable {
            element.tap()
        } else {
            // Try scrolling to find it
            app.swipeUp()
            sleep(1)
            if element.exists && element.isHittable {
                element.tap()
            }
        }
        sleep(1)
    }

    /// Scroll up to 6 times to find an element, then tap it. Returns true if tapped.
    @discardableResult
    private func scrollToAndTap(_ label: String) -> Bool {
        let element = app.staticTexts[label]

        // Already visible?
        if element.waitForExistence(timeout: 2) && element.isHittable {
            element.tap()
            sleep(1)
            return true
        }

        // Scroll down to find it
        for _ in 0..<6 {
            app.swipeUp()
            sleep(1)
            if element.exists && element.isHittable {
                element.tap()
                sleep(1)
                return true
            }
        }

        // Last resort: scroll back to top and try again
        for _ in 0..<6 { app.swipeDown(); usleep(300_000) }
        sleep(1)
        for _ in 0..<8 {
            if element.exists && element.isHittable {
                element.tap()
                sleep(1)
                return true
            }
            app.swipeUp()
            sleep(1)
        }

        return false
    }

    private func goBack() {
        sleep(1)
        // Try navigation bar back button
        let navBar = app.navigationBars.firstMatch
        if navBar.exists {
            let backBtn = navBar.buttons.element(boundBy: 0)
            if backBtn.exists && backBtn.isHittable {
                backBtn.tap()
                sleep(1)
                return
            }
        }
        // Fallback: swipe from left edge
        let start = app.coordinate(withNormalizedOffset: CGVector(dx: 0.02, dy: 0.5))
        let end = app.coordinate(withNormalizedOffset: CGVector(dx: 0.8, dy: 0.5))
        start.press(forDuration: 0.1, thenDragTo: end)
        sleep(1)
    }

    private func tapMainButton() {
        sleep(1)
        let mainBtn = app.buttons["Main"]
        if mainBtn.waitForExistence(timeout: 2) && mainBtn.isHittable {
            mainBtn.tap()
            sleep(1)
            return
        }
        // Fallback
        goBack()
    }

    /// Navigate: Main Menu → Views Catalog → specific view → capture → return to Main Menu
    private func captureViewFromCatalog(label: String, screenId: String) {
        // 1. From main menu, enter Views Catalog
        tap("Views Catalog")

        // 2. Find and tap the view
        if scrollToAndTap(label) {
            sleep(2)
            capture(screenId)
            app.swipeUp()
            sleep(1)
            capture("\(screenId)_scrolled")
        }

        // 3. Return to main menu — try multiple strategies
        returnToMainMenu()
    }

    /// Aggressively return to the main menu from any depth
    private func returnToMainMenu() {
        for attempt in 0..<6 {
            // Check if we're at the main menu
            if app.staticTexts["Components Catalog"].waitForExistence(timeout: 1) &&
               app.staticTexts["Views Catalog"].exists {
                return
            }
            // Try "Main" button (pops to root)
            let mainBtn = app.buttons["Main"]
            if mainBtn.exists && mainBtn.isHittable {
                mainBtn.tap()
                sleep(1)
                continue
            }
            // Try nav bar back button
            let navBar = app.navigationBars.firstMatch
            if navBar.exists {
                let backBtn = navBar.buttons.element(boundBy: 0)
                if backBtn.exists && backBtn.isHittable {
                    backBtn.tap()
                    sleep(1)
                    continue
                }
            }
            // Edge swipe at different y positions to avoid horizontal scroll areas
            let yPositions: [CGFloat] = [0.12, 0.88, 0.5, 0.25, 0.75]
            let dy = yPositions[attempt % yPositions.count]
            let start = app.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: dy))
            let end = app.coordinate(withNormalizedOffset: CGVector(dx: 0.95, dy: dy))
            start.press(forDuration: 0.05, thenDragTo: end)
            sleep(1)
        }

        // Nuclear option: terminate and relaunch if stuck
        if !(app.staticTexts["Components Catalog"].exists &&
             app.staticTexts["Views Catalog"].exists) {
            app.terminate()
            sleep(1)
            app.launch()
            sleep(2)
        }
    }
}
