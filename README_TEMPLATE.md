# NiceViews

A beautiful collection of SwiftUI components and views with comprehensive visual documentation.

## Visual Documentation

This documentation includes actual screenshots of all components in both light and dark modes, generated automatically from our snapshot tests.

## Main Views

### Content View
The main entry point of the application.

**Light Mode:**
![ContentView Light](Documentation/Images/ContentView-light.png)

**Dark Mode:**
![ContentView Dark](Documentation/Images/ContentView-dark.png)

---

### Main View
The primary navigation hub.

**Light Mode:**
![MainView Light](Documentation/Images/MainView-light.png)

**Dark Mode:**
![MainView Dark](Documentation/Images/MainView-dark.png)

---

## Components

### Bottom Tab Bar
A customizable tab bar component.

**Light Mode:**
![BottomTabBar Light](Documentation/Images/BottomTabBar-light.png)

**Dark Mode:**
![BottomTabBar Dark](Documentation/Images/BottomTabBar-dark.png)

---

### Media Card
A card component for displaying media content.

**Light Mode:**
![MediaCard Light](Documentation/Images/MediaCard-light.png)

**Dark Mode:**
![MediaCard Dark](Documentation/Images/MediaCard-dark.png)

---

### Action Button
Styled buttons with different variants.

**Light Mode:**
![ActionButton Light](Documentation/Images/ActionButton-light.png)

**Dark Mode:**
![ActionButton Dark](Documentation/Images/ActionButton-dark.png)

---

## Running Snapshot Tests

To regenerate the visual documentation:

1. Set `isRecording = true` in `ViewSnapshotTests.swift`
2. Run the tests: `cmd+U` in Xcode or `xcodebuild test -scheme NiceViews`
3. Extract snapshots: `./extract_snapshots.sh`
4. The images will be in `Documentation/Images/`

## Installation

Add the package to your project...

## Usage

```swift
import NiceViews

// Use components in your views
MediaCard(
    image: "photo",
    title: "My Content",
    subtitle: "Description"
)
```

## Contributing

Feel free to contribute by adding new components or improving existing ones!