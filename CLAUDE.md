# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

NiceViews is an iOS SwiftUI component library structured as an Xcode project (not a Swift Package yet, despite README aspirations). It provides 27+ reusable UI components with dual theme support (light/dark), enum-driven sizing, and comprehensive snapshot testing. Targets iOS 18.5+.

## Build & Test Commands

```bash
# Build
xcodebuild -scheme NiceViews -destination 'platform=iOS Simulator,name=iPhone 16 Pro'

# Run all tests (snapshot tests only — no unit tests exist)
xcodebuild test -scheme NiceViews -destination 'platform=iOS Simulator,name=iPhone 16 Pro'

# Re-record snapshots: set isRecording = true in NiceViewsTests/ViewSnapshotTests.swift, run tests, then revert
```

## Architecture

### Core Layer (`NiceViews/Core/`)
The foundation — read these four files first to understand everything else:
- **BaseViews.swift** — Generic base views (`BaseNavigationView`, `BaseCatalogView`, `BaseSectionView`, `BaseCardView`, `MenuItemView`) that all higher-level views compose from
- **ViewModifiers.swift** — Reusable modifiers (`CardStyle`, `SectionStyle`, `NavigationStyle`) and custom animations (`.cardFlip`, `.gentleSpring`, `.shimmer`)
- **ConfigurableComponents.swift** — `ComponentConfigurable` protocol with associated config types (`MediaCardConfig`, `ListItemConfig`, `ButtonConfig`, etc.) for declarative component configuration
- **ContentFactory.swift** — Factory pattern via `ContentType` enum for dynamic content generation in demos

### Component Patterns
Every component follows consistent conventions:
- **Enum-driven sizing** — e.g., `MediaCardSize.small/.medium/.large`, `AvatarSize`, etc.
- **Style enums** — `ButtonStyle`, `BadgeStyle`, `GenreTagStyle` for visual variants
- **Optional action callbacks** — `(() -> Void)?` with sensible nil defaults
- **`@ViewBuilder` closures** for generic content injection

### Theme System
`ThemeManager` is an `@EnvironmentObject` singleton with `@Published` dark mode state. It toggles via `UITraitCollection`. The `ThemeToggle` component exposes this in UI. All components must respect the theme.

### Navigation
Custom pop-to-root via `Notification.Name.popToRoot` + `BackToMainButton`. Tab navigation uses `BottomTabBar`/`SafeBottomTabBar` with `AnyView` type erasure for dynamic destinations.

### Directory Purpose
- **Components/** — 27 reusable UI components (the library's public API)
- **DemoViews/** — Interactive demos showcasing component usage
- **TestViews/** — Pre-built full-page views (Home, Explore, Library, etc.) used as integration examples
- **Models/** — Data models consumed by components

## Testing

All tests are **visual regression tests** using Point-Free's `swift-snapshot-testing`. No unit tests.

- Tests live in `NiceViewsTests/ViewSnapshotTests.swift` (75+ tests)
- Every test generates **two snapshots**: light mode + dark mode PNGs
- Custom `ViewImageConfig.iPhone16Pro` config in `SnapshotTestHelpers.swift`
- Snapshots stored in `NiceViewsTests/__Snapshots__/`
- Helper methods: `assertSnapshots()` (full-screen) and `assertFixedSnapshots()` (fixed-size)
- Snapshot wrapper disables animations and fixes font scaling for determinism

## Dependencies

SPM only (managed through Xcode):
- `swift-snapshot-testing` v1.18.4 (Point-Free) — the only direct dependency
