# NiceViews

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5.5+-orange.svg" />
  <img src="https://img.shields.io/badge/iOS-15.0+-blue.svg" />
  <img src="https://img.shields.io/badge/SwiftUI-3.0+-green.svg" />
  <img src="https://img.shields.io/badge/License-MIT-red.svg" />
</p>

A beautiful and comprehensive SwiftUI component library that provides production-ready UI components and pre-built views for iOS applications. NiceViews makes it easy to build stunning, consistent user interfaces with minimal effort.

## ✨ Features

- 🎨 **25+ Reusable Components** - From buttons to complex media cards
- 📱 **15+ Pre-built Views** - Complete screens ready to use
- 🌓 **Full Dark Mode Support** - Seamless theme switching with ThemeManager
- 📸 **Visual Documentation** - Every component documented with screenshots
- 🧪 **Comprehensive Testing** - Snapshot tests for all components and views
- 🏗️ **Modular Architecture** - Clean, maintainable code structure
- 🎯 **Type-Safe** - Leverages Swift's powerful type system
- ⚡ **High Performance** - Optimized for smooth 60fps scrolling

## 📋 Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.5+

## 📦 Installation

### Swift Package Manager

Add NiceViews to your project through Xcode:

1. File → Add Package Dependencies
2. Enter the repository URL: `https://github.com/yourusername/NiceViews`
3. Select "Up to Next Major Version" with "1.0.0"

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/NiceViews", from: "1.0.0")
]
```

## 🚀 Quick Start

```swift
import SwiftUI
import NiceViews

struct MyView: View {
    var body: some View {
        VStack {
            // Use a media card
            MediaCard(
                image: "album_cover",
                title: "Awesome Album",
                subtitle: "Great Artist",
                size: .medium
            )
            
            // Add an action button
            ActionButton(
                title: "Play Now",
                icon: "play.fill",
                style: .primary,
                action: { print("Playing...") }
            )
        }
    }
}
```

## 🎨 Components

### Media Components

#### MediaCard
Display media content with customizable sizes and styles.

```swift
MediaCard(
    image: "thumbnail",
    title: "Song Title",
    subtitle: "Artist Name",
    size: .large,
    showPlayButton: true
)
```

#### VideoThumbnailCard
Perfect for video content with duration overlay.

```swift
VideoThumbnailCard(
    thumbnail: "video_thumb",
    title: "Video Title",
    duration: "10:30",
    views: "1.2M views"
)
```

### Navigation Components

#### BottomTabBar
Customizable tab bar with badge support.

```swift
BottomTabBar(
    items: [
        TabItem(icon: "house", title: "Home", badge: nil),
        TabItem(icon: "magnifyingglass", title: "Search", badge: nil),
        TabItem(icon: "person", title: "Profile", badge: 3)
    ],
    selectedIndex: $selectedTab
)
```

#### SearchBar
Beautiful search input with suggestions.

```swift
SearchBar(
    text: $searchText,
    placeholder: "Search songs, artists, albums...",
    onSubmit: { performSearch() }
)
```

### UI Elements

#### ActionButton
Versatile button component with multiple styles.

```swift
ActionButton(
    title: "Follow",
    icon: "plus",
    style: .secondary,
    size: .medium,
    action: { /* action */ }
)
```

#### StatusBadge
Display status information elegantly.

```swift
StatusBadge(
    text: "LIVE",
    style: .live,
    animated: true
)
```

### Layout Components

#### HorizontalScrollSection
Create beautiful horizontal scrolling sections.

```swift
HorizontalScrollSection(
    title: "Recently Played",
    showSeeAll: true,
    onSeeAll: { /* navigate */ }
) {
    ForEach(items) { item in
        MediaCard(from: item)
    }
}
```

## 📱 Pre-built Views

### HomeView
A complete home screen with featured content, recommendations, and quick access sections.

```swift
HomeView(
    featuredContent: featuredItems,
    recentlyPlayed: recentItems,
    recommendations: recommendedItems
)
```

### ExploreView
Discovery screen with categories, trending content, and search functionality.

```swift
ExploreView(
    categories: categories,
    trending: trendingItems,
    onCategoryTap: { category in
        // Handle category selection
    }
)
```

### ProfileView
User profile screen with stats, content, and settings.

```swift
ProfileView(
    user: currentUser,
    content: userContent,
    onSettingsTap: { /* navigate */ }
)
```

## 🌓 Theme Support

NiceViews includes a powerful theming system:

```swift
// In your app's main view
struct MyApp: App {
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
        }
    }
}

// Toggle theme anywhere
Button("Toggle Theme") {
    themeManager.toggleTheme()
}
```

## 🧪 Testing

### Running Tests

Run all tests:
```bash
xcodebuild test -scheme NiceViews -destination 'platform=iOS Simulator,name=iPhone 14'
```

### Generating Visual Documentation

1. Set `isRecording = true` in `ViewSnapshotTests.swift`
2. Run tests with `Cmd+U` in Xcode
3. Extract snapshots:
   ```bash
   ./extract_snapshots.sh
   ```
4. Find generated images in `Documentation/Images/`

## 📖 Documentation

### Component Playground

Explore components interactively:

```swift
NavigationView {
    ComponentPlaygroundView()
}
```

### Component States Demo

See all component states (loading, error, empty):

```swift
NavigationView {
    ComponentStatesView()
}
```

## 🏗️ Architecture

```
NiceViews/
├── Sources/
│   ├── Components/         # Reusable UI components
│   │   ├── Buttons/
│   │   ├── Cards/
│   │   ├── Navigation/
│   │   └── ...
│   ├── Views/             # Complete view implementations
│   │   ├── Home/
│   │   ├── Explore/
│   │   ├── Profile/
│   │   └── ...
│   ├── Core/              # Core utilities and base classes
│   │   ├── BaseViews.swift
│   │   ├── ThemeManager.swift
│   │   └── ViewModifiers.swift
│   └── Utilities/         # Helper functions and extensions
├── Tests/
│   └── NiceViewsTests/
│       └── ViewSnapshotTests.swift
└── Documentation/
    └── Images/            # Generated component screenshots
```

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Guidelines

- Follow existing code style and conventions
- Add snapshot tests for new components
- Update documentation for new features
- Ensure all tests pass before submitting PR

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- Snapshot testing powered by [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing)
- Inspired by modern design systems

## 💬 Support

- 📧 Email: support@niceviews.com
- 💬 Discord: [Join our community](https://discord.gg/niceviews)
- 🐛 Issues: [GitHub Issues](https://github.com/yourusername/NiceViews/issues)

---

<p align="center">
  Made with ❤️ by the NiceViews Team
</p>