import SwiftUI

struct ComponentPlaygroundView: View {
    @State private var selectedComponent = "MediaCard"
    @State private var cardSize: MediaCardSize = .medium
    @State private var showPlayButton = false
    @State private var cardTitle = "Sample Title"
    @State private var cardSubtitle = "Sample Subtitle"
    @State private var listMetadata = "3:42"
    @State private var buttonStyle: ButtonStyle = .primary
    @State private var buttonTitle = "Action"
    @State private var badgeStyle: BadgeStyle = .new
    @State private var badgeText = "NEW"
    @State private var avatarSize: AvatarSize = .medium
    @State private var showBorder = false
    @State private var userName = "User Name"
    @State private var searchPlaceholder = "Search..."
    @State private var sectionTitle = "Section Title"
    @State private var tabTitles = "Home,Search,Library,Profile"
    @State private var selectedTabIndex = 0
    @State private var iconName = "star.fill"
    @State private var iconSize: CGFloat = 44
    @State private var iconColor = Color.blue
    
    let components = [
        "MediaCard",
        "ListItem",
        "ActionButton",
        "StatusBadge",
        "UserAvatar",
        "HeroSection",
        "SearchBar",
        "SectionHeader",
        "BottomTabBar",
        "TabSelector",
        "IconButton",
        "PlayButton",
        "HorizontalScrollSection",
        "BackToMainButton"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Controls Panel
            VStack(spacing: 16) {
                // Dropdown Menu
                Menu {
                    ForEach(components, id: \.self) { component in
                        Button(component) {
                            selectedComponent = component
                            resetToDefaults()
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedComponent)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 16) {
                        componentControls
                    }
                    .padding()
                }
                .frame(maxHeight: 200)
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            
            Divider()
            
            // Preview Area
            ScrollView {
                VStack(spacing: 20) {
                    Text("Live Preview")
                        .font(.headline)
                        .padding(.top)
                    
                    componentPreview
                        .padding()
                    
                    Spacer(minLength: 50)
                }
            }
        }
        .navigationTitle("Component Playground")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Reset") {
                    resetToDefaults()
                }
            }
        }
    }
    
    @ViewBuilder
    private var componentControls: some View {
        switch selectedComponent {
        case "MediaCard":
            VStack(spacing: 12) {
                HStack {
                    Text("Title:")
                    TextField("Title", text: $cardTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Subtitle:")
                    TextField("Subtitle", text: $cardSubtitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Picker("Size", selection: $cardSize) {
                    Text("Small").tag(MediaCardSize.small)
                    Text("Medium").tag(MediaCardSize.medium)
                    Text("Large").tag(MediaCardSize.large)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Toggle("Show Play Button", isOn: $showPlayButton)
            }
            
        case "ListItem":
            VStack(spacing: 12) {
                HStack {
                    Text("Title:")
                    TextField("Title", text: $cardTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Subtitle:")
                    TextField("Subtitle", text: $cardSubtitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Metadata:")
                    TextField("Metadata", text: $listMetadata)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Toggle("Show Play Button", isOn: $showPlayButton)
            }
            
        case "ActionButton":
            VStack(spacing: 12) {
                HStack {
                    Text("Title:")
                    TextField("Button Text", text: $buttonTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Picker("Style", selection: $buttonStyle) {
                    Text("Primary").tag(ButtonStyle.primary)
                    Text("Secondary").tag(ButtonStyle.secondary)
                    Text("Text").tag(ButtonStyle.text)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
        case "StatusBadge":
            VStack(spacing: 12) {
                HStack {
                    Text("Text:")
                    TextField("Badge Text", text: $badgeText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Picker("Style", selection: $badgeStyle) {
                    Text("Live").tag(BadgeStyle.live)
                    Text("New").tag(BadgeStyle.new)
                    Text("Premium").tag(BadgeStyle.premium)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
        case "UserAvatar":
            VStack(spacing: 12) {
                HStack {
                    Text("Name:")
                    TextField("User Name", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Picker("Size", selection: $avatarSize) {
                    Text("Small").tag(AvatarSize.small)
                    Text("Medium").tag(AvatarSize.medium)
                    Text("Large").tag(AvatarSize.large)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Toggle("Show Border", isOn: $showBorder)
            }
            
        case "HeroSection":
            VStack(spacing: 12) {
                HStack {
                    Text("Title:")
                    TextField("Hero Title", text: $cardTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Subtitle:")
                    TextField("Hero Subtitle", text: $cardSubtitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Badge:")
                    TextField("Badge Text", text: $badgeText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            
        case "SearchBar":
            VStack(spacing: 12) {
                HStack {
                    Text("Placeholder:")
                    TextField("Placeholder Text", text: $searchPlaceholder)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            
        case "SectionHeader":
            VStack(spacing: 12) {
                HStack {
                    Text("Title:")
                    TextField("Section Title", text: $sectionTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Subtitle:")
                    TextField("Section Subtitle", text: $cardSubtitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            
        case "BottomTabBar", "TabSelector":
            VStack(spacing: 12) {
                HStack {
                    Text("Tab Titles:")
                    TextField("Comma separated", text: $tabTitles)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Stepper("Selected Tab: \(selectedTabIndex)", value: $selectedTabIndex, in: 0...3)
            }
            
        case "IconButton":
            VStack(spacing: 12) {
                HStack {
                    Text("Icon:")
                    TextField("SF Symbol", text: $iconName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Slider(value: $iconSize, in: 20...80, step: 4) {
                    Text("Size: \(Int(iconSize))")
                }
                
                ColorPicker("Icon Color", selection: $iconColor)
            }
            
        case "PlayButton":
            VStack(spacing: 12) {
                Slider(value: $iconSize, in: 20...80, step: 4) {
                    Text("Size: \(Int(iconSize))")
                }
            }
            
        case "HorizontalScrollSection":
            VStack(spacing: 12) {
                Text("This component is a container")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Toggle("Show with content", isOn: $showPlayButton)
            }
            
        case "BackToMainButton":
            VStack(spacing: 12) {
                Text("Navigation button - no customization needed")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var componentPreview: some View {
        switch selectedComponent {
        case "MediaCard":
            ConfigurableMediaCard(config: MediaCardConfig(
                title: cardTitle,
                subtitle: cardSubtitle,
                size: cardSize,
                showPlayButton: showPlayButton,
                imageUrl: nil
            ))
            
        case "ListItem":
            ConfigurableListItem(config: ListItemConfig(
                title: cardTitle,
                subtitle: cardSubtitle,
                metadata: listMetadata,
                showPlayButton: showPlayButton,
                imageUrl: nil,
                trailingView: nil
            ))
            .cardStyle()
            
        case "ActionButton":
            ConfigurableActionButton(
                config: ButtonConfig(
                    title: buttonTitle,
                    icon: "star.fill",
                    style: buttonStyle,
                    isEnabled: true
                )
            ) {
                print("Button tapped")
            }
            
        case "StatusBadge":
            ConfigurableStatusBadge(config: BadgeConfig(
                text: badgeText,
                style: badgeStyle
            ))
            
        case "UserAvatar":
            ConfigurableUserAvatar(config: AvatarConfig(
                name: userName,
                size: avatarSize,
                showBorder: showBorder,
                imageUrl: nil
            ))
            
        case "HeroSection":
            if let sampleImage = SampleData.heroImages.first {
                EnhancedHeroSection(
                    imageUrl: sampleImage.url,
                    title: cardTitle,
                    subtitle: cardSubtitle,
                    badge: badgeText.isEmpty ? nil : badgeText,
                    primaryAction: { print("Primary") },
                    secondaryAction: { print("Secondary") }
                )
                .frame(height: 300)
                .clipped()
            }
            
        case "SearchBar":
            @State var searchText = ""
            SearchBar(text: $searchText, placeholder: searchPlaceholder)
                .padding(.horizontal)
            
        case "SectionHeader":
            SectionHeader(
                title: sectionTitle,
                subtitle: cardSubtitle.isEmpty ? nil : cardSubtitle,
                showSeeAll: true,
                onSeeAll: { print("See all tapped") }
            )
            
        case "BottomTabBar":
            let tabs = tabTitles.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
            VStack {
                Spacer()
                Text("Selected Tab: \(tabs[min(selectedTabIndex, tabs.count - 1)])")
                    .font(.title2)
                Spacer()
                SafeBottomTabBar(
                    selectedTab: .constant(selectedTabIndex),
                    items: tabs.enumerated().map { index, title in
                        SafeTabItem(
                            title: title,
                            icon: ["house.fill", "magnifyingglass", "books.vertical.fill", "person.fill"][min(index, 3)]
                        )
                    }
                )
            }
            
        case "TabSelector":
            let tabs = tabTitles.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
            VStack {
                TabSelector(selectedIndex: .constant(selectedTabIndex), tabs: tabs)
                Spacer()
                    .frame(height: 50)
                Text("Selected: \(tabs[min(selectedTabIndex, tabs.count - 1)])")
                    .font(.title3)
            }
            
        case "IconButton":
            IconButton(
                icon: iconName,
                size: iconSize,
                backgroundColor: iconColor.opacity(0.2),
                foregroundColor: iconColor
            ) {
                print("Icon button tapped")
            }
            
        case "PlayButton":
            PlayButton(size: iconSize)
            
        case "HorizontalScrollSection":
            if showPlayButton {
                HorizontalScrollSection {
                    ForEach(0..<5) { index in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 150, height: 100)
                            .overlay(
                                Text("Item \(index + 1)")
                                    .foregroundColor(.blue)
                            )
                    }
                }
            } else {
                Text("Enable 'Show with content' to see the container")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            
        case "BackToMainButton":
            BackToMainButton()
            
        default:
            Text("Select a component to preview")
                .foregroundColor(.secondary)
        }
    }
    
    private func resetToDefaults() {
        cardTitle = "Sample Title"
        cardSubtitle = "Sample Subtitle"
        cardSize = .medium
        showPlayButton = false
        listMetadata = "3:42"
        buttonStyle = .primary
        buttonTitle = "Action"
        badgeStyle = .new
        badgeText = "NEW"
        avatarSize = .medium
        showBorder = false
        userName = "User Name"
        searchPlaceholder = "Search..."
        sectionTitle = "Section Title"
        tabTitles = "Home,Search,Library,Profile"
        selectedTabIndex = 0
        iconName = "star.fill"
        iconSize = 44
        iconColor = .blue
    }
}

struct ComponentPlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ComponentPlaygroundView()
        }
    }
}