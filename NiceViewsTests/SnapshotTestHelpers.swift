//
//  SnapshotTestHelpers.swift
//  NiceViewsTests
//
//  Helper utilities for snapshot testing
//

import SwiftUI
import SnapshotTesting
@testable import NiceViews

/// Wrapper view that provides a stable environment for snapshot testing
struct SnapshotWrapper<Content: View>: View {
    let content: Content
    @StateObject private var themeManager = ThemeManager.shared
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .environmentObject(themeManager)
            // Ensure consistent font scaling
            .environment(\.sizeCategory, .medium)
            // Disable animations for consistent snapshots
            .transaction { transaction in
                transaction.animation = nil
            }
            // Add a small delay to ensure images load
            .onAppear {
                // Force a render cycle
                DispatchQueue.main.async {
                    // This helps ensure SF Symbols are loaded
                }
            }
    }
}

/// Helper to create consistent test data
struct TestData {
    static let sampleImage = "photo"
    static let sampleIcon = "star.fill"
    static let sampleAvatar = "person.circle.fill"
    
    static let tabItems = [
        TabItem(title: "Home", icon: "house.fill", destination: AnyView(Text("Home"))),
        TabItem(title: "Search", icon: "magnifyingglass", destination: AnyView(Text("Search"))),
        TabItem(title: "Library", icon: "books.vertical.fill", destination: AnyView(Text("Library"))),
        TabItem(title: "Profile", icon: "person.fill", destination: AnyView(Text("Profile")))
    ]
    
    static let safeTabItems = [
        SafeTabItem(title: "Home", icon: "house.fill"),
        SafeTabItem(title: "Search", icon: "magnifyingglass"),
        SafeTabItem(title: "Library", icon: "books.vertical.fill"),
        SafeTabItem(title: "Profile", icon: "person.fill")
    ]
}

/// Extension to add a delay before snapshot
extension Snapshotting where Value == UIViewController, Format == UIImage {
    static func imageWithDelay(
        on config: ViewImageConfig,
        delay: TimeInterval = 0.1,
        traits: UITraitCollection = .init()
    ) -> Snapshotting {
        return Snapshotting<UIViewController, UIImage>.image(
            on: config,
            traits: traits
        ).asyncPullback { viewController in
            Async { callback in
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    callback(viewController)
                }
            }
        }
    }
}
