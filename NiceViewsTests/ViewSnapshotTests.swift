//
//  ViewSnapshotTests.swift
//  NiceViewsTests
//
//  Created for generating visual documentation of all views
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import NiceViews

// Custom device config for iPhone 16 Pro if not available
extension ViewImageConfig {
    public static let iPhone16Pro = ViewImageConfig(
        safeArea: UIEdgeInsets(top: 59, left: 0, bottom: 34, right: 0),
        size: CGSize(width: 430, height: 932),
        traits: UITraitCollection(
            traitsFrom: [
                UITraitCollection(displayScale: 3),
                UITraitCollection(userInterfaceIdiom: .phone)
            ]
        )
    )
}

class ViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Record mode will generate new snapshots
        // Set to false to test against existing snapshots
//        isRecording = true
    }
    
    // Helper function to snapshot in both light and dark modes
    func assertSnapshots<V: View>(
        of view: V,
        named name: String? = nil,
        device: ViewImageConfig = .iPhone16Pro,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        // Light mode snapshot
        assertSnapshot(
            of: view,
            as: .image(
                layout: .device(config: device),
                traits: .init(userInterfaceStyle: .light)
            ),
            named: name.map { "\($0)-light" },
            file: file,
            testName: testName,
            line: line
        )
        
        // Dark mode snapshot
        assertSnapshot(
            of: view,
            as: .image(
                layout: .device(config: device),
                traits: .init(userInterfaceStyle: .dark)
            ),
            named: name.map { "\($0)-dark" },
            file: file,
            testName: testName,
            line: line
        )
    }
    
    // Helper for fixed size snapshots in both modes
    func assertFixedSnapshots<V: View>(
        of view: V,
        named name: String? = nil,
        width: CGFloat,
        height: CGFloat,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        // Light mode
        assertSnapshot(
            of: view,
            as: .image(
                layout: .fixed(width: width, height: height),
                traits: .init(userInterfaceStyle: .light)
            ),
            named: name.map { "\($0)-light" },
            file: file,
            testName: testName,
            line: line
        )
        
        // Dark mode
        assertSnapshot(
            of: view,
            as: .image(
                layout: .fixed(width: width, height: height),
                traits: .init(userInterfaceStyle: .dark)
            ),
            named: name.map { "\($0)-dark" },
            file: file,
            testName: testName,
            line: line
        )
    }
    
    // MARK: - Main Application Views
    
    func testContentView() {
        let view = ContentView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testMainView() {
        let view = MainView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testNavigationRoot() {
        let view = NavigationRoot()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    // MARK: - Feature Views
    
    func testViewsCatalogView() {
        let view = ViewsCatalogView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testComponentsCatalogView() {
        let view = ComponentsCatalogView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testComponentPlaygroundView() {
        let view = ComponentPlaygroundView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testAnimationShowcaseView() {
        let view = AnimationShowcaseView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testComponentStatesView() {
        let view = ComponentStatesView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testChatExperienceView() {
        let view = ChatExperienceView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    // MARK: - Test Views
    
    func testHomeView() {
        let view = HomeView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testHomeView2() {
        let view = HomeView2()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testExploreView() {
        let view = ExploreView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testExploreView2() {
        let view = ExploreView2()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testLibraryView() {
        let view = LibraryView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testProfileView() {
        let view = ProfileView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    // MARK: - Components (Isolated)
    
    func testBottomTabBar() {
        let items = [
            TabItem(title: "Home", icon: "house.fill", destination: AnyView(Text("Home"))),
            TabItem(title: "Search", icon: "magnifyingglass", destination: AnyView(Text("Search"))),
            TabItem(title: "Profile", icon: "person.fill", destination: AnyView(Text("Profile")))
        ]
        let view = BottomTabBar(selectedTab: .constant(0), items: items)
            .environmentObject(ThemeManager.shared)
        assertFixedSnapshots(of: view, width: 430, height: 100)
    }
    
    func testSafeBottomTabBar() {
        let items = [
            SafeTabItem(title: "Home", icon: "house.fill"),
            SafeTabItem(title: "Search", icon: "magnifyingglass"),
            SafeTabItem(title: "Profile", icon: "person.fill")
        ]
        let view = SafeBottomTabBar(selectedTab: .constant(0), items: items)
            .environmentObject(ThemeManager.shared)
        assertFixedSnapshots(of: view, width: 430, height: 120)
    }
    
    func testMediaCard() {
        let view = MediaCard(
            image: "photo",
            title: "Sample Media",
            subtitle: "Description text"
        )
        .environmentObject(ThemeManager.shared)
        assertFixedSnapshots(of: view, width: 300, height: 400)
    }
    
    func testListItem() {
        let view = ListItem(
            image: "star.fill",
            title: "Sample Item",
            subtitle: "Description",
            metadata: "$99.99"
        )
        .environmentObject(ThemeManager.shared)
        assertFixedSnapshots(of: view, width: 430, height: 80)
    }
    
    func testSearchBar() {
        let view = SearchBar(text: .constant(""))
            .environmentObject(ThemeManager.shared)
        assertFixedSnapshots(of: view, width: 430, height: 60)
    }
    
    func testSectionHeader() {
        let view = SectionHeader(title: "Section Title", showSeeAll: true)
            .environmentObject(ThemeManager.shared)
        assertFixedSnapshots(of: view, width: 430, height: 50)
    }
    
    func testUserAvatar() {
        let view = VStack(spacing: 20) {
            UserAvatar(name: "John Doe", size: .small)
            UserAvatar(name: "Jane Smith", size: .medium)
            UserAvatar(name: "Bob Johnson", size: .large)
        }
        .environmentObject(ThemeManager.shared)
        assertFixedSnapshots(of: view, width: 200, height: 300)
    }
    
    func testStatusBadge() {
        let view = HStack(spacing: 20) {
            StatusBadge(text: "LIVE", style: .live)
            StatusBadge(text: "NEW", style: .new)
            StatusBadge(text: "PRO", style: .premium)
        }
        .environmentObject(ThemeManager.shared)
        assertFixedSnapshots(of: view, width: 400, height: 60)
    }
    
    func testTabSelector() {
        let view = TabSelector(
            selectedIndex: .constant(0),
            tabs: ["All", "Recent", "Popular", "Trending"]
        )
        .environmentObject(ThemeManager.shared)
        assertFixedSnapshots(of: view, width: 430, height: 60)
    }
    
    func testActionButton() {
        let view = VStack(spacing: 20) {
            ActionButton(title: "Primary Button", style: .primary) {}
            ActionButton(title: "Secondary Button", style: .secondary) {}
            ActionButton(title: "Text Button", style: .text) {}
        }
        .environmentObject(ThemeManager.shared)
        assertFixedSnapshots(of: view, width: 300, height: 200)
    }
    
    func testIconButton() {
        let view = HStack(spacing: 20) {
            IconButton(icon: "heart") {}
            IconButton(icon: "star", foregroundColor: .blue) {}
            IconButton(icon: "trash", backgroundColor: .red.opacity(0.2), foregroundColor: .red) {}
        }
        .environmentObject(ThemeManager.shared)
        assertFixedSnapshots(of: view, width: 200, height: 60)
    }
    
    func testHeroSection() {
        let view = HeroSection(
            image: "star.fill",
            title: "Welcome to NiceViews",
            subtitle: "Beautiful SwiftUI Components",
            badge: "NEW",
            primaryAction: nil,
            secondaryAction: nil
        )
        .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    // MARK: - Cell Components and Collections
    
    func testListItemVariations() {
        let view = VStack(spacing: 0) {
            // Music item
            ListItem(
                image: "music.note",
                title: "Bohemian Rhapsody",
                subtitle: "Queen",
                metadata: "5:55",
                showPlayButton: true
            )
            
            Divider()
            
            // Video item
            ListItem(
                image: "play.rectangle.fill",
                title: "SwiftUI Tutorial",
                subtitle: "Learn the basics",
                metadata: "12:34",
                showPlayButton: true
            )
            
            Divider()
            
            // Settings item
            ListItem(
                image: "gear",
                title: "General",
                subtitle: "Display & Brightness",
                trailing: AnyView(
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                )
            )
            
            Divider()
            
            // Simple item
            ListItem(
                image: "folder.fill",
                title: "Documents",
                metadata: "42 items"
            )
        }
        .environmentObject(ThemeManager.shared)
        assertFixedSnapshots(of: view, width: 430, height: 320)
    }
    
    func testMediaCardSizes() {
        let view = HStack(spacing: 20) {
            VStack {
                MediaCard(
                    image: "photo",
                    title: "Small Card",
                    subtitle: "Compact size",
                    size: .small
                )
                Text("Small").font(.caption)
            }
            
            VStack {
                MediaCard(
                    image: "photo",
                    title: "Medium Card",
                    subtitle: "Default size",
                    size: .medium
                )
                Text("Medium").font(.caption)
            }
            
            VStack {
                MediaCard(
                    image: "photo",
                    title: "Large Card",
                    subtitle: "Big size",
                    size: .large
                )
                Text("Large").font(.caption)
            }
        }
        .padding()
        .environmentObject(ThemeManager.shared)
        assertFixedSnapshots(of: view, width: 700, height: 450)
    }
    
    func testMediaCardGrid() {
        let items = [
            ("music.note", "Album 1", "Artist A"),
            ("play.circle.fill", "Video 1", "Creator B"),
            ("photo", "Photo 1", "Gallery C"),
            ("book.fill", "Book 1", "Author D"),
            ("gamecontroller.fill", "Game 1", "Studio E"),
            ("tv.fill", "Show 1", "Network F")
        ]
        
        let view = ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                ForEach(0..<6, id: \.self) { index in
                    MediaCard(
                        image: items[index].0,
                        title: items[index].1,
                        subtitle: items[index].2,
                        size: .small
                    )
                }
            }
            .padding()
        }
        .frame(width: 430, height: 400)
        .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testListItemCollection() {
        let view = List {
            Section("Music") {
                ForEach(0..<3, id: \.self) { index in
                    ListItem(
                        image: "music.note",
                        title: "Song \(index + 1)",
                        subtitle: "Artist \(index + 1)",
                        metadata: "3:4\(index)",
                        showPlayButton: true
                    )
                }
            }
            
            Section("Videos") {
                ForEach(0..<3, id: \.self) { index in
                    ListItem(
                        image: "play.rectangle.fill",
                        title: "Video \(index + 1)",
                        subtitle: "Channel \(index + 1)",
                        metadata: "\(index + 10)K views"
                    )
                }
            }
        }
        .listStyle(.insetGrouped)
        .frame(width: 430, height: 500)
        .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testHorizontalScrollSection() {
        let view = VStack(alignment: .leading) {
            SectionHeader(title: "Featured Content", showSeeAll: true)
            
            HorizontalScrollSection {
                HStack(spacing: 12) {
                    ForEach(0..<5, id: \.self) { index in
                        MediaCard(
                            image: ["music.note", "play.circle", "photo", "book", "gamecontroller"][index],
                            title: "Item \(index + 1)",
                            subtitle: "Description",
                            size: .medium
                        )
                    }
                }
            }
        }
        .frame(height: 280)
        .environmentObject(ThemeManager.shared)
        assertFixedSnapshots(of: view, width: 430, height: 280)
    }
    
    func testMenuItemView() {
        let view = VStack(spacing: 0) {
            MenuItemView(
                icon: "house.fill",
                iconColor: .blue,
                title: "Home",
                subtitle: "Go to main screen",
                destination: Text("Home View")
            )
            
            Divider()
            
            MenuItemView(
                icon: "gear",
                iconColor: .gray,
                title: "Settings",
                subtitle: "App preferences",
                destination: Text("Settings View")
            )
            
            Divider()
            
            MenuItemView(
                icon: "questionmark.circle",
                iconColor: .orange,
                title: "Help",
                subtitle: "Get support",
                destination: Text("Help View")
            )
        }
        .environmentObject(ThemeManager.shared)
        assertFixedSnapshots(of: view, width: 430, height: 180)
    }
    
    
    
    // MARK: - Demo Views
    
    func testMediaCardDemoView() {
        let view = MediaCardDemoView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testListItemDemoView() {
        let view = ListItemDemoView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testHeroSectionDemoView() {
        let view = HeroSectionDemoView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    func testBottomTabBarDemoView() {
        let view = BottomTabBarDemoView()
            .environmentObject(ThemeManager.shared)
        assertSnapshots(of: view)
    }
    
    
}

